//
//  PatientMapViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 29.04.2022.
//

import UIKit
import MapKit

class PatientMapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var medicalCenterViewModel = MedicalCenterViewModel()
    
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
                //self.medicalCenterCollectionView.reloadData()
                print("400==> \(self.medicalCenters)")
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
        
//        let london = MKPointAnnotation()
//        london.title = "Alina"
//        london.coordinate = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
//        mapView.addAnnotation(london)

        
        print("////// \(medicalCenters)")
        
//        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(initialPlace.latitude, initialPlace.longitude), span: <#MKCoordinateSpan#>), animated: true)

        let region = MKCoordinateRegion( center: initialPlace, latitudinalMeters: CLLocationDistance(exactly: 2000)!, longitudinalMeters: CLLocationDistance(exactly: 2000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)

    }
//    
    func loadData() {
//        doctorViewModel.getAllDoctors(collectionID: "doctors") { doctors in
//                self.doctors = doctors
//        }
        medicalCenterViewModel.getAllMedicalCenters(collectionID: "medicalCenters") { medicalCenters in
                self.medicalCenters = medicalCenters
        }

    }

    
    func createMedicalCentersMapList(medicalCenters: [MedicalCenter]) {
        
        for medicalCenter in medicalCenters {
            let latitude = Double(medicalCenter.latitude)!
            let longitude = Double(medicalCenter.longitude)!
            let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let medicalCenterForMap = MedicalCenterForMap(locationName: medicalCenter.name, coordinate: coordinates)
            //medicalCenterForMap.locationName = medicalCenter.name
            medicalCentersMapList.append(medicalCenterForMap)
            
        }
        
        print("yyyyyyy \(medicalCentersMapList)")
    }
    
    
    func showMedicalCentersOnMap() {
        for medicalCenterMap in medicalCentersMapList {
            mapView.addAnnotation(medicalCenterMap)
        }
    }

}

