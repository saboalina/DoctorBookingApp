//
//  MedicalCenterHorizontalViewCell.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 24.04.2022.
//

import UIKit

class MedicalCenterHorizontalViewCell: UICollectionViewCell {

   
    @IBOutlet weak var medicalCenterNameLabel: UILabel!
    
    static let identifier = String(describing: MedicalCenterHorizontalViewCell.self)
    
    func setup(medicalCenter: MedicalCenter){
        medicalCenterNameLabel.text = medicalCenter.name
    }
    
}
