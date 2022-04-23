//
//  PatientHomePageViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 17.04.2022.
//

import UIKit

class PatientPageViewController: UITabBarController, UITabBarControllerDelegate {
    
    var patient: Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        guard let viewControllers = viewControllers else { return }
        
        for viewController in viewControllers {
            if let patientProfileNavigationController = viewController as? PatientProfileNavigationController{
                if let patientProfileViewController = patientProfileNavigationController.viewControllers.first as? PatientProfileViewController {
                    patientProfileViewController.patient = patient!
                }
            }
            
            if let patientAppointmentsNavigationController = viewController as? PatientAppointmentsNavigationController{
                if let patientAppointmentsViewController = patientAppointmentsNavigationController.viewControllers.first as? PatientAppointmentsViewController {
                    patientAppointmentsViewController.patient = patient!
                }
            }
        }
    }

}
