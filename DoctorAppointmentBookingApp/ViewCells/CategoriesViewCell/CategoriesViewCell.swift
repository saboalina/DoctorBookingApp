//
//  CategoriesViewCell.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 24.04.2022.
//

import UIKit

class CategoriesViewCell: UICollectionViewCell {

   
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    static let identifier = String(describing: CategoriesViewCell.self)
    
    func setup(category: Category) {
        categoryNameLabel.text = category.name
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0
    }
    
}
