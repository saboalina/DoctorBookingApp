//
//  AppointmentPatientViewCell.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 26.04.2022.
//

import UIKit

class AppointmentPatientViewCell: UITableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var doctorLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
