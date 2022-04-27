//
//  PatientSearchViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 27.04.2022.
//

import UIKit

class PatientSearchViewController: UIViewController {
    
    
    @IBOutlet weak var areaLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        areaLabel.placeholder = "Select Area"
        dateLabel.placeholder = "Select Date"
        nameLabel.placeholder = "Doctor, Specialist"
    }
    
    func setTexts(segmentIndex: Int) {
        areaLabel.placeholder = "Select Area"
        dateLabel.placeholder = "Select Date"
        if segmentIndex == 0 {
            nameLabel.placeholder = "Doctor, Specialist"
        } else {
            nameLabel.placeholder = "Medical Center"
        }
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            setTexts(segmentIndex: 0)
        }
        if sender.selectedSegmentIndex == 1 {

            setTexts(segmentIndex: 1)
        }
    }
    
    

    
}
