
import UIKit

class PatientEditProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var historyTextView: UITextView!
    
    
    var patientViewModel = PatientViewModel.shared
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print("aici e \(patientId)")
        nameTextField.text = patient.name
        phoneTextField.text = patient.phoneNumber
        historyTextView.text = patient.history
        
        setDesign()
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
    
    func setDesign() {
        
        
        title = "Edit My Profile"
        view.backgroundColor = Colors.brown
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.darkBlue]

        historyTextView.layer.shadowColor = UIColor.black.cgColor
        historyTextView.layer.cornerRadius = 10
                
    }
    
    func navigateToPatientProfile() {        
        navigationController?.popViewController(animated: true)
    }

    
}
