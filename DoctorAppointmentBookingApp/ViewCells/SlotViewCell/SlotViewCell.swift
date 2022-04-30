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
    }
}
