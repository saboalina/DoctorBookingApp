

import UIKit
import Firebase

class PatientProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var historyTextView: UITextView!
    
    var patientViewModel = PatientViewModel.shared
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.patientViewModel.getPatientBy(email: patient!.email, handler: { res in
            switch res{
            case .success(let patient):
                self.patient = patient
                self.setLabels()
            case .failure(let err):
                print(err)
            }

        })
    }
    
    func setLabels() {
        nameLabel.text = patient.name
        emailLabel.text = patient.email
        phoneLabel.text = patient.phoneNumber
        historyTextView.text = patient.history
    }
    

    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        let firstPage = storyboard?.instantiateInitialViewController()
     
        view.window?.rootViewController = firstPage
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let editProfilePage = storyboard?.instantiateViewController(withIdentifier: "editProfilePage") as? PatientEditProfileViewController
        
        editProfilePage?.patient = patient
     
        navigationController?.pushViewController(editProfilePage!, animated: true)
    }
}
