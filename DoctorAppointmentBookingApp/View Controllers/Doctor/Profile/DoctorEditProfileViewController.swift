

import UIKit

class DoctorEditProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var serviceTextField: UITextField!
    @IBOutlet weak var servicesAtTextField: UITextView!
    @IBOutlet weak var experienceTextField: UITextField!
    @IBOutlet weak var consultancyFeeTextField: UITextField!
    
    var doctorViewModel = DoctorViewModel.shared
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
        
        doctorViewModel.updateDoctor(doctorId: doctor!.id, name: name, phoneNumber: phoneNumber, service: service, worksAt: worksAt, experience: experience, consultancyFee: consultancyFee) { success in
            if success {
                self.navigateToDoctorProfile()
            } else {
                print("eroare")
            }
            
        }
    }
    
    func navigateToDoctorProfile() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigateToDoctorProfile()
    }
}
