//
//  SignUpViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 03.04.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var doctorViewModel = DoctorViewModel()
    var patientViewModel = PatientViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let string = "veronica@yahoo.com"

        if string.range(of:"@yahoo.com") != nil {
            print("exists")
        } else {
            print("not")
        }

        if string.contains("@yahoo.com") != nil {
            print("exists456")
        } else {
            print("not456")
        }
    }
    
    func validateFields() -> String? {
                
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                 
                return "Please fill in all fields"
        }
    
        return nil
    }
    
    func verifyUser(email: String) -> String {
        var user = ""

        // alternative: not case sensitive
        if email.lowercased().contains("@yahoo.com") {
            print("exists")
            user = "is a patient"
        } else {
            user = "is a doctor"
        }
        
        return user
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let error = validateFields()
                
        if error != nil {
            
            showError(error!)
                    
        } else {
                    
            let email = self.emailTextField.text ?? ""
            let name = self.nameTextField.text ?? ""
            let phoneNumber = self.phoneNumberTextField.text ?? ""
            let password = self.passwordTextField.text ?? ""
            let confirmPassword = self.confirmPasswordTextField.text ?? ""
            
            var userType = verifyUser(email: email)
            
            if userType == "is a patient" {
                
                let patient = Patient(email: email, password: password, name: name, phoneNumber: phoneNumber, history: "", id: "")
                
                patientViewModel.createUser(patient: patient) {[weak self] (success) in
                    guard let `self` = self else { return }
                    if (success) {
                        self.performSegue(withIdentifier: "loadLoginPage", sender: self)
                    } else {
                        self.errorLabel.text = "There was an error."
                    }
                }
                
            } else {
                
                let doctor = Doctor(email: email, password: password, name: name, phoneNumber: phoneNumber, worksAt: "", numberOfPatients: "", experience: "", consultancyFee: "", service: "", id: "",
                                    sun: "", mon: "", tue: "", wed: "", thu: "", fri: "", sat: "")
                
                doctorViewModel.createUser(doctor: doctor) {[weak self] (errorCode) in
                    guard let `self` = self else { return }
                    if let err = errorCode {
                        self.errorLabel.text = "\(errorCode)"
//                        switch err {
//                        case .invalidEmail:
//                            self.errorLabel.text = "Invalid email"
//                        }
                        
                    } else {
                        self.performSegue(withIdentifier: "loadLoginPage", sender: self)
                                              //print("success")
//                          self.errorLabel.text = "success"
//                          self.emailTextField.text = ""
//                          self.nameTextField.text = ""
//                          self.phoneNumberTextField.text = ""
//                          self.passwordTextField.text = ""
                    }
                }
            }
                                
            
        }

    }
    
    func showError(_ message:String) {
            errorLabel.text = message
    }
        
    func transitionToHome() {
        
        let loginPage = storyboard?.instantiateViewController(withIdentifier: "LoginPage") as? LoginViewController
     
        view.window?.rootViewController = loginPage
        view.window?.makeKeyAndVisible()
    }

}
