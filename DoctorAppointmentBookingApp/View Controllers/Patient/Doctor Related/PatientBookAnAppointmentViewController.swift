//
//  PatientBookAnAppointmentViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 30.04.2022.
//

import UIKit

class PatientBookAnAppointmentViewController: UIViewController {
    
    
    @IBOutlet weak var appointmentDatePicker: UIDatePicker!
    
    @IBOutlet weak var slotsCollectionView: UICollectionView!
    
    var filterViewModel = FiltersViewModel.shared
    var appointmentViewModel = AppointmentViewModel()
    
    var patient: Patient!
    var doctor: Doctor!
    var appointmentDate: String = ""
    var appointmentTime: String = ""
    var slots: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentDatePicker.datePickerMode = UIDatePicker.Mode.date
        print(appointmentDatePicker.date)
        appointmentDatePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        registerCells()
    }
        
    @objc func datePickerChanged(picker: UIDatePicker) {
        print("\(picker.date)")
        
        let dateInfoString = "\(picker.date)"
        let dateInfo = dateInfoString.components(separatedBy: " ")
        appointmentDate = dateInfo[0]
        
        let day = filterViewModel.getDayOfTheWeekByDate(date: picker.date)
        if day == "Mon" {
            slots = doctor.mon.components(separatedBy: ",")
            print(doctor.mon)
        }
        if day == "Tue" {
            slots = doctor.tue.components(separatedBy: ",")
            print(doctor.tue)
        }
        if day == "Wed" {
            slots = doctor.wed.components(separatedBy: ",")
            print(doctor.wed)
        }
        if day == "Thu" {
            slots = doctor.thu.components(separatedBy: ",")
            print(doctor.thu)
        }
        if day == "Fri" {
            slots = doctor.fri.components(separatedBy: ",")
            print(doctor.fri)
        }
        if day == "Sat" {
            slots = doctor.sat.components(separatedBy: ",")
            print(doctor.sat)
        }
        if day == "Sun" {
            slots = doctor.sun.components(separatedBy: ",")
            print(doctor.sun)
        }
        slotsCollectionView.reloadData()
        print(day)
    }
    
    @IBAction func confirmAppointmentButtonTapped(_ sender: Any) {
        print(appointmentDatePicker.date)
        let appointment = Appointment(patientId: patient.email, doctorId: doctor.email, date: appointmentDate, time: appointmentTime, type: doctor.service, id: "")
        appointmentViewModel.addAppointment(appointment: appointment) { success in
            if (success) {
                //self.appointments.remove(at: rowIndex)
                print("tuto bene")
            } else {
                //self.errorLabel.text = "There was an error."
                print("There was an error.")
            }
        }
    }
    
    private func registerCells() {
        slotsCollectionView.register(UINib(nibName: SlotViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SlotViewCell.identifier)
        
    }

}

extension PatientBookAnAppointmentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlotViewCell.identifier, for: indexPath) as! SlotViewCell
        cell.setup(slot: slots[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(slots[indexPath.row])
        appointmentTime = slots[indexPath.row]
    }
    
    
}
