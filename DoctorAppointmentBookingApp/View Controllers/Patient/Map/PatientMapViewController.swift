
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
    
    let initialPlace = CLLocationCoordinate2D(latitude: 46.753893594342465, longitude: 23.54748262695039)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

        let region = MKCoordinateRegion( center: initialPlace, latitudinalMeters: CLLocationDistance(exactly: 2000)!, longitudinalMeters: CLLocationDistance(exactly: 2000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        
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

}

