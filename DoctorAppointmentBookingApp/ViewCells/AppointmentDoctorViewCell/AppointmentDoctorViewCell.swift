//
//  AppointmentDoctorViewCell.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 26.04.2022.
//

import UIKit

class AppointmentDoctorViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var doneButton: ButtonClassBlue!
    @IBOutlet weak var cancelButton: ButtonClassOrange!
    
    @IBOutlet weak var contentViewUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        contentViewUIView.clipsToBounds = false;
//        contentViewUIView.layer.masksToBounds = false;
//        
//        contentViewUIView.layer.shadowColor = UIColor.black.cgColor
//        contentViewUIView.layer.shadowOffset = CGSize(width: 3, height: 3)
//        contentViewUIView.layer.shadowOpacity = 0.3
//        contentViewUIView.layer.shadowRadius = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
