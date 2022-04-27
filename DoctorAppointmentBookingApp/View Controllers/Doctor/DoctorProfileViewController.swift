//
//  DoctorProfileViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 03.04.2022.
//

import UIKit
import Firebase

class DoctorProfileViewController: UIViewController {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var servicesAtLabel: UITextField!
    @IBOutlet weak var patientNumberLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var consultanceFeeLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!

    
    var doctor: Doctor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = doctor.name
        emailLabel.text = doctor.email
        phoneLabel.text = doctor.phoneNumber
        serviceLabel.text = doctor.service
        servicesAtLabel.text = doctor.worksAt
        patientNumberLabel.text = doctor.numberOfPatients
        experienceLabel.text = doctor.experience
        consultanceFeeLabel.text = doctor.consultancyFee

        
    }
    

    @IBAction func logoutButtonTapped(_ sender: Any) {
        
//        do {
//            try Auth.auth().signOut()
//        } catch let logoutError {
//            print(logoutError)
//        }
        
        //storyboard?.instantiateInitialViewController()
        
        let firstPage = storyboard?.instantiateInitialViewController()
     
        view.window?.rootViewController = firstPage
        view.window?.makeKeyAndVisible()
    }

}
