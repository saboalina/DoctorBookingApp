//
//  PatientDoctorsListViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 30.04.2022.
//

import UIKit

class PatientDoctorsListViewController: UIViewController {
    
    
    @IBOutlet weak var doctorsTableView: UITableView!
    
    var doctors: [Doctor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("'''''' \(doctors)")
    }

}

extension PatientDoctorsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorVerticalViewCell") as! DoctorVerticalViewCell
        cell.nameLabel.text = "Dr. \(doctors[indexPath.row].name)"
        cell.serviceLabel.text = "\(doctors[indexPath.row].service) Specialist"
        cell.experienceLabel.text = "Experience: \(doctors[indexPath.row].experience)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doctor = doctors[indexPath.row]
        //var doctorsList = filterViewModel.getDoctorsBy(service: service)
        //print("[][] \(service)")
        //filterViewModel.getDoctorsBy(service: service)
//        doctorViewModel.getDoctorsBy(service: service) { doctors in
//            doctorsList = doctors
//        }
        
        performSegue(withIdentifier: "fromDoctorListToDoctorDetails", sender: doctor)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromDoctorListToDoctorDetails" {
            if let doctorDetailsViewConntroller = segue.destination as? PatientDoctorDetailsViewController {
                doctorDetailsViewConntroller.doctor =  sender as! Doctor
            }
        }
        
    }
    
}
