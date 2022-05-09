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

    var doctorViewModel = DoctorViewModel.shared
    var doctor: Doctor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        
    }
    
    func setLabels() {
        nameLabel.text = doctor.name
        emailLabel.text = doctor.email
        phoneLabel.text = doctor.phoneNumber
        serviceLabel.text = doctor.service
        servicesAtLabel.text = doctor.worksAt
        patientNumberLabel.text = doctor.numberOfPatients
        experienceLabel.text = doctor.experience
        consultanceFeeLabel.text = doctor.consultancyFee

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.doctorViewModel.getDoctorBy(email: doctor!.email, handler: { res in
            switch res{
            case .success(let doctor):
                self.doctor = doctor
                //self.navigateToDoctorProfile(doctor: doctor)
                self.setLabels()
            case .failure(let err):
                print(err)
            }

        })
        
        
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
    
    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        let editDoctorProfilePage = storyboard?.instantiateViewController(withIdentifier: "editDoctorProfilePage") as? DoctorEditProfileViewController
        
        editDoctorProfilePage?.doctor = doctor
     
//        view.window?.rootViewController = editDoctorProfilePage
//        view.window?.makeKeyAndVisible()
        
        navigationController?.pushViewController(editDoctorProfilePage!, animated: true)
    }
}
