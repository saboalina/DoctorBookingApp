//
//  PatientSearchViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 27.04.2022.
//

import UIKit

class PatientSearchViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 0 {
//            setTexts(segmentIndex: 0)
//        }
//        if sender.selectedSegmentIndex == 1 {
//
//            setTexts(segmentIndex: 1)
//        }
    }
    
    
    @IBAction func selectDateButtonTapped(_ sender: Any) {
        let selectDateProfilePage = storyboard?.instantiateViewController(withIdentifier: "selectDateProfilePage") as? PatientSelectDateViewController
        
        //selectDateProfilePage?.doctor = doctor
     
//        view.window?.rootViewController = editDoctorProfilePage
//        view.window?.makeKeyAndVisible()
        
        navigationController?.pushViewController(selectDateProfilePage!, animated: true)
    }
    
    
}
