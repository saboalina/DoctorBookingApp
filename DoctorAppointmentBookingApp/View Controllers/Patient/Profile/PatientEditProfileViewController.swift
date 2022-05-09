
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
    }
    
    func navigateToPatientProfile() {        
        navigationController?.popViewController(animated: true)
    }

    
}
