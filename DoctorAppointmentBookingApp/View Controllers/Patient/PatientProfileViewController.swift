//
//  PatientProfileViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 17.04.2022.
//

import UIKit
import Firebase

class PatientProfileViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var historyTextField: UITextField!
    
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = patient.name
        emailTextField.text = patient.email
        phoneTextField.text = patient.phoneNumber
        historyTextField.text = patient.history

    }
    

    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        let firstPage = storyboard?.instantiateInitialViewController()
     
        view.window?.rootViewController = firstPage
        view.window?.makeKeyAndVisible()
    }
    
}
