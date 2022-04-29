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
    
    var doctorSearch: Bool!
    
    var filterViewModel = FiltersViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        filterViewModel.doctorSearch = doctorSearch
    }
    

    @IBAction func filterButtonTapped(_ sender: Any) {
        
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        filterViewModel.getWeekDaysList(startDate: startDate, endDate: endDate)
    }
    
    
    

}
