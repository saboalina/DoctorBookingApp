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
    var doctorViewModel = DoctorViewModel()
    
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

    
    func loadData() {
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentPatientViewCell") as! AppointmentPatientViewCell
        
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        //cell.accessoryType = .disclosureIndicator
        
        cell.dateLabel.text = appointments[indexPath.row].date
        cell.timeLabel.text = appointments[indexPath.row].time
        
        self.doctorViewModel.getDoctorBy(email: appointments[indexPath.row].doctorId, handler: { res in
            switch res{
            case .success(let doctor):
                cell.doctorLabel.text = doctor.name
//                        self.performSegue(withIdentifier: "loadDoctorHomePage", sender: self)
                //self.navigateToDoctorPage(doctor: doctor)
            case .failure(let err):
                print(err)
            }
        })
        //cell.doctorLabel.text = appointments[indexPath.row].doctorId
        cell.placeLabel.text = "Cluj-Napoca"
        cell.typeLabel.text = appointments[indexPath.row].type
        cell.layer.borderWidth = 20
        cell.layer.borderColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.cancelButton.tag = indexPath.row
        cell.cancelButton.layer.cornerRadius = 5
        cell.cancelButton.addTarget(self, action: #selector(deleteAppointment(sender:)), for: .touchUpInside)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 20, dy: 10)
        cell.layer.mask = maskLayer
    }
    
    @objc
    func deleteAppointment(sender: UIButton){
        let rowIndex = sender.tag
        //do something
        print(rowIndex)
        print(appointments[rowIndex].doctorId)
        
        appointmentViewModel.deleteAppointment(appointment: appointments[rowIndex]) { [weak self] (success) in
            guard let `self` = self else { return }
            if (success) {
                //self.appointments.remove(at: rowIndex)
                self.appointmentsTableView.reloadData()
            } else {
                //self.errorLabel.text = "There was an error."
                print("There was an error.")
            }
        }
    }
    
}
