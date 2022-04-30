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
        if doctorSearch == true {
            let doctorsList = filterViewModel.getAvailableDoctors(startDate: startDate, endDate: endDate)
            performSegue(withIdentifier: "fromSearchToDoctorsList", sender: doctorsList)
        } else {
            let medicaCentersList = filterViewModel.getAvailableMedicalCenters(startDate: startDate, endDate: endDate)
            performSegue(withIdentifier: "fromSearchToMedicalCentersList", sender: medicaCentersList)
            //print("se merge catre lista de centre medicale")
        }

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSearchToDoctorsList" {
            if let fromMedicalDetailsToDoctorsList = segue.destination as? PatientDoctorsListViewController {
                fromMedicalDetailsToDoctorsList.doctors =  sender as! [Doctor]
            }
        }
        
        if segue.identifier == "fromSearchToMedicalCentersList" {
            if let fromSearchToMedicalCentersList = segue.destination as? PatientMedicalCentersListViewController {
                fromSearchToMedicalCentersList.medicalCenters =  sender as! [MedicalCenter]
            }
        }
    }
    

}
