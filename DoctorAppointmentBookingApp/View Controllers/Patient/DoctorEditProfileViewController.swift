//
//  DoctorEditProfileViewController.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 28.04.2022.
//

import UIKit

class DoctorEditProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var serviceTextField: UITextField!
    @IBOutlet weak var servicesAtTextField: UITextView!
    @IBOutlet weak var experienceTextField: UITextField!
    @IBOutlet weak var consultancyFeeTextField: UITextField!
    
    var doctorViewModel = DoctorViewModel()
    var doctor: Doctor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.text = doctor?.name
        phoneTextField.text = doctor?.phoneNumber
        serviceTextField.text = doctor?.service
        servicesAtTextField.text = doctor?.worksAt
        experienceTextField.text = doctor?.experience
        consultancyFeeTextField.text = doctor?.consultancyFee
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let name = nameTextField.text!
        let phoneNumber = phoneTextField.text!
        let service = serviceTextField.text!
        let worksAt = servicesAtTextField.text!
        let experience = experienceTextField.text!
        let consultancyFee = consultancyFeeTextField.text!
        
        doctorViewModel.updateDoctor(doctorId: doctor!.id, name: name, phoneNumber: phoneNumber, service: service, worksAt: worksAt, experience: experience, consultancyFee: consultancyFee)
        
        self.doctorViewModel.getDoctorBy(email: doctor!.email, handler: { res in
            switch res{
            case .success(let doctor):
                self.doctor = doctor
                self.navigateToDoctorProfile(doctor: doctor)
            case .failure(let err):
                print(err)
            }
        
        })
    }
    
    func navigateToDoctorProfile(doctor: Doctor) {
        let doctorProfilePage = storyboard?.instantiateViewController(withIdentifier: "doctorProfilePage") as? DoctorProfileViewController

        doctorProfilePage?.doctor = doctor

        view.window?.rootViewController = doctorProfilePage
        view.window?.makeKeyAndVisible()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        let doctor = self.doctor!
        self.navigateToDoctorProfile(doctor: doctor)
    }
}
