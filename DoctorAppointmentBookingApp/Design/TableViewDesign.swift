//
//  TableViewDesign.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 13.05.2022.
//

import Foundation

import Foundation
import UIKit

class TableViewDesign: UITableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4.0
        
        clipsToBounds = false;
        layer.masksToBounds = false;
        
    }
}
