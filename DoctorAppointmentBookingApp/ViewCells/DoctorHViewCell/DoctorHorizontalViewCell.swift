//
//  DoctorHorizontalViewCell.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 23.04.2022.
//

import UIKit

class DoctorHorizontalViewCell: UICollectionViewCell {

   
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
//    @IBOutlet weak var doctorServiceLabel: UILabel!
//    @IBOutlet weak var doctorExperienceLabel: UILabel!
//    @IBOutlet weak var doctorPatientsLabel: UILabel!
    
    static let identifier = String(describing: DoctorHorizontalViewCell.self)
    
    
    func setup(doctor: Doctor) {
        doctorNameLabel.text = doctor.name
//        doctorServiceLabel.text = "\(doctor.service) Specialist"
//        doctorExperienceLabel.text = doctor.experience
//        doctorPatientsLabel.text = doctor.numberOfPatients
        
    }
}
