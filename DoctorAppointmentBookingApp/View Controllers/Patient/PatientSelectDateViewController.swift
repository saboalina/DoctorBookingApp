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
    
    var filterViewModel = FiltersViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func filterButtonTapped(_ sender: Any) {
        
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        filterViewModel.getWeekDaysList(startDate: startDate, endDate: endDate)
    }
    
    
    

}
