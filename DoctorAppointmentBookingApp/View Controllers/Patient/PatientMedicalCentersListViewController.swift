//
//  PatientMedicalCentersListViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 30.04.2022.
//

import UIKit

class PatientMedicalCentersListViewController: UIViewController {
    
    
    @IBOutlet weak var medicalCenterTableView: UITableView!
    
    var medicalCenters: [MedicalCenter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension PatientMedicalCentersListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicalCenters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalCenterVerticalViewCell") as! MedicalCenterVerticalViewCell
        cell.nameLabel.text = medicalCenters[indexPath.row].name
        cell.addressLabel.text = medicalCenters[indexPath.row].address
        //cell.experienceLabel.text = "Experience: \(doctors[indexPath.row].experience)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let medicalCenter = medicalCenters[indexPath.row]
        //var doctorsList = filterViewModel.getDoctorsBy(service: service)
        //print("[][] \(service)")
        //filterViewModel.getDoctorsBy(service: service)
//        doctorViewModel.getDoctorsBy(service: service) { doctors in
//            doctorsList = doctors
//        }
        
        performSegue(withIdentifier: "fromMCListToMCDetails", sender: medicalCenter)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromMCListToMCDetails" {
            if let medicalCenterDetailsViewConntroller = segue.destination as? PatientMedicalCenterDetailsViewController {
                medicalCenterDetailsViewConntroller.medicalCenter =  sender as! MedicalCenter
            }
        }
        
    }
}
