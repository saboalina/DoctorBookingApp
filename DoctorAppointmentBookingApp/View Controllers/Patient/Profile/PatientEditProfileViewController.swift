
import UIKit

class PatientEditProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var historyTextView: UITextView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var patientViewModel = PatientViewModel.shared
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print("aici e \(patientId)")
        nameTextField.text = patient.name
        phoneTextField.text = patient.phoneNumber
        historyTextView.text = patient.history
        
        setDesign()
        setProfilePicture()
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
        historyTextView.textColor = Colors.darkBlue
        nameTextField.textColor = Colors.darkBlue
        phoneTextField.textColor = Colors.darkBlue
                
    }
    
    func setProfilePicture() {
        if let profilePictureURL = patient.imageURL {
            let url = NSURL(string: profilePictureURL)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    return
                }
                DispatchQueue.main.sync {
                    self.profileImageView.image  = UIImage(data: data!)
                    self.profileImageView.contentMode = .scaleAspectFill
                }
            }).resume()
        }
    }
    
    func navigateToPatientProfile() {        
        navigationController?.popViewController(animated: true)
    }

    
}
