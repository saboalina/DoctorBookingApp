//
//  CategoriesViewCell.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 24.04.2022.
//

import UIKit

class CategoriesViewCell: UICollectionViewCell {

   
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    static let identifier = String(describing: CategoriesViewCell.self)
    
    func setup(category: String) {
        categoryNameLabel.text = category
    }
    
}
