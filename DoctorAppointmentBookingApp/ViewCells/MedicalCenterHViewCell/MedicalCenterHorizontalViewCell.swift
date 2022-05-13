//
//  MedicalCenterHorizontalViewCell.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 24.04.2022.
//

import UIKit

class MedicalCenterHorizontalViewCell: UICollectionViewCell {

   
    @IBOutlet weak var medicalCenterNameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    static let identifier = String(describing: MedicalCenterHorizontalViewCell.self)
    
    func setup(medicalCenter: MedicalCenter){
        medicalCenterNameLabel.text = medicalCenter.name
        addressLabel.text = medicalCenter.address
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0
    }
    
}
