//
//  PatientEditProfileViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 27.04.2022.
//

import UIKit

class PatientEditProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var historyTextView: UITextView!
    
    
    var patientViewModel = PatientViewModel.shared
    var patient: Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print("aici e \(patientId)")
        nameTextField.text = patient?.name
        phoneTextField.text = patient?.phoneNumber
        historyTextView.text = patient?.history
    }
    

    @IBAction func saveButtonTapped(_ sender: Any) {
        let name = nameTextField.text!
        let phoneNumber = phoneTextField.text!
        let history = historyTextView.text!
        
        patientViewModel.updatePatient(patientId: patient!.id, name: name, phoneNumber: phoneNumber, history: history) { success in
            if success {
                self.navigateToPatientProfile()
            } else {
                print("eroare")
            }
            
        }
        
//        self.patientViewModel.getPatientBy(email: patient!.email, handler: { res in
//            switch res{
//            case .success(let patient):
//                self.patient = patient
//                self.navigateToPatientProfile(pacient: patient)
//            case .failure(let err):
//                print(err)
//            }
//
//        })
    }
    
    func navigateToPatientProfile() {
//        let patientProfilePage = storyboard?.instantiateViewController(withIdentifier: "patientProfilePage") as? PatientProfileViewController
//
//        patientProfilePage?.patient = patient
//
//        view.window?.rootViewController = patientProfilePage
//        view.window?.makeKeyAndVisible()
//        self.navigationController?.popToRootViewController(animated: true)
        
        navigationController?.popViewController(animated: true)
    }

    
}
