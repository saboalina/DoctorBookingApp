
import UIKit


class ResetPasswordViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    var doctorViewModel = DoctorViewModel.shared
    var patientViewModel = PatientViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    @IBAction func resetPasswordButtonTapped(_ sender: Any) {
        let email = emailTextField.text!
        var user = ""
        if email.lowercased().contains("@med.com") {
            user = "is a doctor"
        } else {
            user = "is a patient"
        }
        
        if user == "is a doctor" {
            doctorViewModel.resetPassword(email: email, onSuccess: {
                self.navigateToFirstPage()
            }) {
                (errorMessage) in
                print("reset pass error")

            }
        } else {
            patientViewModel.resetPassword(email: email, onSuccess: {
                print("reset pass success")
                self.navigateToFirstPage()
            }) {
                (errorMessage) in
                print("reset pass error")

            }
        }
    }
    
    func navigateToFirstPage() {
        let firstPage = self.storyboard?.instantiateInitialViewController()
     
        self.view.window?.rootViewController = firstPage
        self.view.window?.makeKeyAndVisible()
    }
}
