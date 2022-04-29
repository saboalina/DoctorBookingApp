//
//  PatientSearchViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 27.04.2022.
//

import UIKit

class PatientSearchViewController: UIViewController {
    
    var doctorSearch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            doctorSearch = true
        }
        if sender.selectedSegmentIndex == 1 {
            doctorSearch = false
        }
    }
    
    
    @IBAction func selectDateButtonTapped(_ sender: Any) {
        let selectDateProfilePage = storyboard?.instantiateViewController(withIdentifier: "selectDateProfilePage") as? PatientSelectDateViewController
        
        
        selectDateProfilePage?.doctorSearch = doctorSearch
     
//        view.window?.rootViewController = editDoctorProfilePage
//        view.window?.makeKeyAndVisible()
        
        navigationController?.pushViewController(selectDateProfilePage!, animated: true)
    }
    
    
}
