
import UIKit
import MapKit
import UserNotifications

class PatientMapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var medicalCenterViewModel = MedicalCenterViewModel()
    
    var patient: Patient!
    
    private var allMedicalCenters = [MedicalCenter]() {
        didSet {
            DispatchQueue.main.async {
                self.medicalCenters = self.allMedicalCenters
                print("3==> \(self.medicalCenters)")
            }
        }
    }

    var medicalCenters = [MedicalCenter]() {
        didSet {
            DispatchQueue.main.async {
                self.createMedicalCentersMapList(medicalCenters: self.medicalCenters)
                self.showMedicalCentersOnMap()
                self.verifyDistance()
            }
        }
    }
    
    var medicalCentersMapList = [MedicalCenterForMap]()
        
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        loadData()
        
        print("in PatientMapViewController \(patient.name)")

    }
    
    func loadData() {
        medicalCenterViewModel.getAllMedicalCenters(collectionID: "medicalCenters") { medicalCenters in
                self.medicalCenters = medicalCenters
        }

    }

    
    func createMedicalCentersMapList(medicalCenters: [MedicalCenter]) {
        
        for medicalCenter in medicalCenters {
            let latitude = Double(medicalCenter.latitude)!
            let longitude = Double(medicalCenter.longitude)!
            let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let medicalCenterForMap = MedicalCenterForMap(title:medicalCenter.name, coordinate: coordinates)
            //medicalCenterForMap.locationName = medicalCenter.name
            medicalCentersMapList.append(medicalCenterForMap)
            
        }
    }
    
    
    func showMedicalCentersOnMap() {
        for medicalCenterMap in medicalCentersMapList {
            mapView.addAnnotation(medicalCenterMap)
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
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
    
    func verifyDistance() {
        //print(currentLocation)
        let currentCoordinate = CLLocation(latitude: currentLocation!.latitude, longitude: currentLocation!.longitude)
        for medicalCenterOnMap in medicalCentersMapList {
            
            let medicalCoordinate = CLLocation(latitude: medicalCenterOnMap.coordinate.latitude, longitude: medicalCenterOnMap.coordinate.longitude)
            let distanceInMeters = currentCoordinate.distance(from: medicalCoordinate)
            if distanceInMeters < 200 {
                print("in verifyInitialDistance e aproape \(distanceInMeters)")
                getNotification(medicalCenterForMap: medicalCenterOnMap)
            }
        }
    }
    
    func getNotification(medicalCenterForMap: MedicalCenterForMap) {
        
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Notification"
        content.body = "You are close to the parking lot \(medicalCenterForMap.title!) and there are 100 free spaces"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "yourIdentifier"
        content.userInfo = ["example": "information"] // You can retrieve this when displaying notification
        
        let date = convertDate(date: Date() + 5)
                
        let trigger = UNCalendarNotificationTrigger(dateMatching: date as DateComponents, repeats: false)
        
        // Create request
        let uniqueID = UUID().uuidString // Keep a record of this if necessary
        let request = UNNotificationRequest(identifier: uniqueID, content: content, trigger: trigger)
        center.add(request) // Add the notification request
    }
    
    func convertDate(date: Date) -> NSDateComponents {
        print(date)

        let calendar = Calendar.current

        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)

        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let sec = calendar.component(.second, from: date)

        let newDate = NSDateComponents()

        print("\(year):\(month):\(day)" + " " + "\(hour):\(minutes):\(sec)")

        newDate.timeZone = TimeZone.current

        newDate.hour = hour
        newDate.minute = minutes
        newDate.second = sec

        newDate.day = day
        newDate.month = month
        newDate.year = year

        print("\(newDate.year):\(newDate.month):\(newDate.day)" + " " + "\(newDate.hour):\(newDate.minute):\(newDate.second) zone:\(TimeZone.current)")

        return newDate
    }

}

extension PatientMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
        {
            if let annotationTitle = view.annotation?.title
            {
                print("User tapped on annotation with title: \(annotationTitle!)")
            }
        }
}

extension PatientMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did get latest location")
        guard let latestLocation = locations.first else { return }
        zoomToLatestLocation(with: latestLocation.coordinate)
        currentLocation = latestLocation.coordinate
        verifyDistance()
    }
    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("the status changed")
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            beginLocationUpdates(locationManager: manager)
        }
    }
}

