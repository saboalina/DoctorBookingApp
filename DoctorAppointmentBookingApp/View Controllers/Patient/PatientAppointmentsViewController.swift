//
//  PatientAppointmentsViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 17.04.2022.
//

import UIKit
import FirebaseFirestore

class PatientAppointmentsViewController: UIViewController {

    
    @IBOutlet weak var appointmentsTableView: UITableView!
    var patientViewModel = PatientViewModel()
    var appointmentViewModel = AppointmentViewModel()
    
    var patient: Patient!
    
    
    private var allAppointments = [Appointment]() {
        didSet {
            DispatchQueue.main.async {
                self.appointments = self.allAppointments
            }
        }
    }
        
    var appointments = [Appointment]() {
        didSet {
            DispatchQueue.main.async {
                self.appointmentsTableView.reloadData()
            }
        }
    }
    
//
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(appointmentsTableView)
        appointmentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        appointmentsTableView.dataSource = self
        appointmentsTableView.delegate = self
        
        loadData()
        print("=====> \(patient)")
        

    }
    
    func filterAppointments() {
        
    }
    
    func loadData() {
//        doctorViewModel.getAllDoctors(collectionID: "doctors") { doctors in
//                self.doctors = doctors
//        }
//        print("2==> \(doctors)")
        appointmentViewModel.getAllAppointmentsForAPatient(collectionID: "appointments", patientEmail: patient.email) { appointments in
                self.appointments = appointments
        }
    }

}

extension PatientAppointmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = appointments[indexPath.row].patientId
        cell.detailTextLabel?.text = appointments[indexPath.row].doctorId
        return cell
    }
    
    
}

