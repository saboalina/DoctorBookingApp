
import UIKit
import MapKit
import UserNotifications

class PatientMapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var medicalCenterViewModel = MedicalCenterViewModel.shared
    var parkingLotViewModel = ParkingLotViewModel.shared
    
    var patient: Patient!
    var medicalCenter: MedicalCenter!
    
    private var allMedicalCenters = [MedicalCenter]() {
        didSet {
            DispatchQueue.main.async {
                self.medicalCenters = self.allMedicalCenters
            }
        }
    }

    var medicalCenters = [MedicalCenter]() {
        didSet {
            DispatchQueue.main.async {
                self.createMedicalCentersMapList(medicalCenters: self.medicalCenters)
                self.showMedicalCentersOnMap()
            }
        }
    }
    
    private var allParkingLots = [ParkingLot]() {
        didSet {
            DispatchQueue.main.async {
                self.parkingLots = self.allParkingLots
            }
        }
    }

    var parkingLots = [ParkingLot]() {
        didSet {
            DispatchQueue.main.async {
                self.createParkingLotsMapList(parkingLots: self.parkingLots)
                self.showParkingLotsOnMap()
                //self.verifyDistance()
            }
        }
    }
    
    var medicalCentersMapList = [MedicalCenterForMap]()
    var parkingLotsMapList = [ParkingLotForMap]()

        
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?
    var zoomIndex = 2000
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        loadData()
        view.backgroundColor = Colors.brown

    }
    
    func loadData() {
        medicalCenterViewModel.getAllMedicalCenters(collectionID: "medicalCenters") { medicalCenters in
                self.medicalCenters = medicalCenters
        }
        
        parkingLotViewModel.getAllParkingLots(collectionID: "parkingLots") { parkingLots in
                self.parkingLots = parkingLots
        }

    }

    
    func createMedicalCentersMapList(medicalCenters: [MedicalCenter]) {

        for medicalCenter in medicalCenters {
            let latitude = Double(medicalCenter.latitude)!
            let longitude = Double(medicalCenter.longitude)!
            let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let medicalCenterForMap = MedicalCenterForMap(title:medicalCenter.name, coordinate: coordinates)
            medicalCentersMapList.append(medicalCenterForMap)

        }
    }
    
    func createParkingLotsMapList(parkingLots: [ParkingLot]) {
    
        for parkingLot in parkingLots {
            let latitude = Double(parkingLot.latitude)!
            let longitude = Double(parkingLot.longitude)!
            let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let parkingLotForMap = ParkingLotForMap(title:parkingLot.name, coordinate: coordinates)
            parkingLotsMapList.append(parkingLotForMap)

        }
    }
    
    func showMedicalCentersOnMap() {
        for medicalCenterMap in medicalCentersMapList {
            mapView.addAnnotation(medicalCenterMap)
        }
    }
    
    func showParkingLotsOnMap() {
        for parkingLotMap in parkingLotsMapList {
            mapView.addAnnotation(parkingLotMap)
        }
    }
    
    private func configureLocationServices() {
        locationManager.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager) {
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: CLLocationDistance(zoomIndex), longitudinalMeters: CLLocationDistance(zoomIndex))
        mapView.setRegion(region, animated: true)
    }
    
    func verifyDistance() {
        let currentCoordinate = CLLocation(latitude: currentLocation!.latitude, longitude: currentLocation!.longitude)
        
        for parkingLotOnMap in parkingLotsMapList {
            
            let parkingCoordinate = CLLocation(latitude: parkingLotOnMap.coordinate.latitude, longitude: parkingLotOnMap.coordinate.longitude)
            let distanceInMeters = currentCoordinate.distance(from: parkingCoordinate)
            if distanceInMeters < 500 {
                getNotification(parkingLotForMap: parkingLotOnMap)
            }
        }
    }
    
    
    func getNotification(parkingLotForMap: ParkingLotForMap) {
        
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Notification"
        let freeSpaces = Int.random(in: 1..<100)
        content.body = "You are close to the parking lot \(parkingLotForMap.title!) and there are \(freeSpaces) free spaces"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "yourIdentifier"
        content.userInfo = ["example": "information"]
        
        let date = convertDate(date: Date() + 5)
                
        let trigger = UNCalendarNotificationTrigger(dateMatching: date as DateComponents, repeats: false)
        
        let uniqueID = UUID().uuidString
        let request = UNNotificationRequest(identifier: uniqueID, content: content, trigger: trigger)
        center.add(request)
    }
    
    func convertDate(date: Date) -> NSDateComponents {

        let calendar = Calendar.current

        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)

        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let sec = calendar.component(.second, from: date)

        let newDate = NSDateComponents()

        newDate.timeZone = TimeZone.current

        newDate.hour = hour
        newDate.minute = minutes
        newDate.second = sec

        newDate.day = day
        newDate.month = month
        newDate.year = year

        return newDate
    }
    
    func navigateToMedicalCenterPage(medicalCenter: MedicalCenter) {
        performSegue(withIdentifier: "showMedicalCenterDetailsFromMap", sender: medicalCenter)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                
        if segue.identifier == "showMedicalCenterDetailsFromMap" {
            if let medicalCenterDetailsViewConntroller = segue.destination as? PatientMedicalCenterDetailsViewController {
                medicalCenterDetailsViewConntroller.medicalCenter =  sender as! MedicalCenter
                medicalCenterDetailsViewConntroller.patient = patient
            }
        }
        
    }

}

extension PatientMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotationTitle = view.annotation?.title {
            let medicalCenterName = annotationTitle!
            self.medicalCenterViewModel.getMedicalCenterBy(name: medicalCenterName, handler: { res in
                switch res{
                case .success(let medicalCenter):
                    self.medicalCenter = medicalCenter
                    self.navigateToMedicalCenterPage(medicalCenter: medicalCenter)
                case .failure(let err):
                    print(err)
                }
            })
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation")
        var annotationView = Pin.init(annotation: annotation, reuseIdentifier: "myAnnotation")

        
        if let annotation = annotation as? MedicalCenterForMap {
            annotationView.pinTintColor = Colors.blue
            annotationView.setLabel(text: annotation.title ?? "")
        } else if let annotation = annotation as? ParkingLotForMap {
            annotationView.pinTintColor = Colors.orange
            annotationView.setLabel(text: annotation.title ?? "")
        } else {
            annotationView.pinTintColor = Colors.darkBlue
            annotationView.setLabel(text: "I'm here")
        }
        return annotationView
    }
}

extension PatientMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else { return }
        zoomToLatestLocation(with: latestLocation.coordinate)
        currentLocation = latestLocation.coordinate
        verifyDistance()
    }
    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            beginLocationUpdates(locationManager: manager)
        }
    }
}

