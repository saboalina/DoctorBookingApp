//
//  SlotViewCell.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 30.04.2022.
//

import UIKit

class SlotViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var slotLabel: UILabel!
    
    static let identifier = String(describing: SlotViewCell.self)
    
    func setup(slot: String) {
        slotLabel.text = slot
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0
        
        layer.cornerRadius = 10
        
        tintColor = Colors.darkBlue
    }
}
