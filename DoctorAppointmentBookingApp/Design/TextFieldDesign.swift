//
//  TextFieldDesign.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 12.05.2022.
//

import Foundation
import UIKit

class TextFieldDesign: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0
        
    }
}
