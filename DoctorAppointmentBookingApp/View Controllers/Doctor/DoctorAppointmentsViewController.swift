//
//  DoctorAppointmentsViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 10.04.2022.
//

import UIKit
import FirebaseFirestore

class DoctorAppointmentsViewController: UIViewController {

    
    @IBOutlet weak var appointmentsTableView: UITableView!
    var doctorViewModel = DoctorViewModel()
    var appointmentViewModel = AppointmentViewModel()
    
    var doctor: Doctor!
    
//    private var allDoctors = [Doctor]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.doctors = self.allDoctors
//                print("3==> \(self.doctors)")
//            }
//        }
//    }
//
//    var doctors = [Doctor]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.appointmentsTableView.reloadData()
//                print("4==> \(self.doctors)")
//            }
//        }
//    }
    
    
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
        print("=====> \(doctor)")
        

    }
    
    func filterAppointments() {
        
    }
    
    func loadData() {
//        doctorViewModel.getAllDoctors(collectionID: "doctors") { doctors in
//                self.doctors = doctors
//        }
//        print("2==> \(doctors)")
        appointmentViewModel.getAllAppointmentsForADoctor(collectionID: "appointments", doctorEmail: doctor.email) { appointments in
                self.appointments = appointments
        }
    }

}

extension DoctorAppointmentsViewController: UITableViewDataSource, UITableViewDelegate {
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
