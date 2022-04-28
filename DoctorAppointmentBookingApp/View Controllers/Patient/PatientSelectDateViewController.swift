//
//  PatientSelectDateViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 28.04.2022.
//

import UIKit

class PatientSelectDateViewController: UIViewController {

    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

    @IBAction func filterButtonTapped(_ sender: Any) {
        
        print("---> \(startDatePicker.date)")
        print("---> \(endDatePicker.date)")
        //startDatePicker.date
        
    }
    

}
