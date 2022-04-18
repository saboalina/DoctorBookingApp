//
//  DoctorHomePageViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 03.04.2022.
//

import UIKit

class DoctorHomePageViewController: UITabBarController, UITabBarControllerDelegate {
    
    var doctor: Doctor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        guard let viewControllers = viewControllers else { return }
        
        for viewController in viewControllers {
            if let doctorProfileNavigationController = viewController as? DoctorProfileNavigationController{
                if let doctorProfileViewController = doctorProfileNavigationController.viewControllers.first as? DoctorProfileViewController {
                    doctorProfileViewController.doctor = doctor!
                }
            }
            
            if let doctorAppointmentsNavigationController = viewController as? DoctorAppointmentsNavigationController{
                if let doctorAppointmentsViewController = doctorAppointmentsNavigationController.viewControllers.first as? DoctorAppointmentsViewController {
                    doctorAppointmentsViewController.doctor = doctor!
                }
            }
        }
    }

}
