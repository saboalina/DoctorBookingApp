
import UIKit
import MapKit

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
            }
        }
    }
    
    var medicalCentersMapList = [MedicalCenterForMap]()
    
    //let initialPlace = CLLocationCoordinate2D(latitude: 46.753893594342465, longitude: 23.54748262695039)
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        loadData()

//        let region = MKCoordinateRegion( center: initialPlace, latitudinalMeters: CLLocationDistance(exactly: 2000)!, longitudinalMeters: CLLocationDistance(exactly: 2000)!)
//        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        
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
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }

}

extension PatientMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did get latest location")
        guard let latestLocation = locations.first else { return }
        
//        if currentLocation == nil {
//            zoomToLatestLocation(with: latestLocation.coordinate)
//        }
        zoomToLatestLocation(with: latestLocation.coordinate)
        currentLocation = latestLocation.coordinate
    }
    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("the status changed")
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            beginLocationUpdates(locationManager: manager)
        }
    }
}

