//
//  DoctorProfileViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 03.04.2022.
//

import UIKit
import Firebase

class DoctorProfileViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var serviceTextField: UITextField!
    @IBOutlet weak var worksAtTextField: UITextField!
//    @IBOutlet weak var numberOfPatientsTextField: UITextField!
//    @IBOutlet weak var experienceTextField: UITextField!
//    @IBOutlet weak var consultancyFeeTextField: UITextField!
    @IBOutlet weak var logoutButton: UIButton!

    
    var doctor: Doctor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = doctor.name
        emailTextField.text = doctor.email
        phoneTextField.text = doctor.phoneNumber
        serviceTextField.text = doctor.service
        worksAtTextField.text = doctor.worksAt
//        numberOfPatientsTextField.text = doctor.numberOfPatients
//        experienceTextField.text = doctor.experience
//        consultancyFeeTextField.text = doctor.consultancyFee
        
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
