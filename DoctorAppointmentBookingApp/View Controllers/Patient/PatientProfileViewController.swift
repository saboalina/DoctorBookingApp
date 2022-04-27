//
//  PatientProfileViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 17.04.2022.
//

import UIKit
import Firebase

class PatientProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var historyTextField: UITextField!
    
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = patient.name
        emailLabel.text = patient.email
        phoneLabel.text = patient.phoneNumber
        historyTextField.text = patient.history

    }
    

    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        let firstPage = storyboard?.instantiateInitialViewController()
     
        view.window?.rootViewController = firstPage
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let editProfilePage = storyboard?.instantiateViewController(withIdentifier: "editProfilePage") as? PatientEditProfileViewController
        
        editProfilePage?.patient = patient
     
        view.window?.rootViewController = editProfilePage
        view.window?.makeKeyAndVisible()
    }
    
//    func navigateToPatientPage(pacient: Patient) {
//        let patientPage = storyboard?.instantiateViewController(withIdentifier: "PatientPage") as? PatientPageViewController
//        
//        patientPage?.patient = patient
//     
//        view.window?.rootViewController = patientPage
//        view.window?.makeKeyAndVisible()
//    }
}
