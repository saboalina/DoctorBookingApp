
import UIKit


class ResetPasswordViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    var doctorViewModel = DoctorViewModel.shared
    var patientViewModel = PatientViewModel.shared
    
    @IBOutlet weak var enterEmailLabel: UILabel!
    
    @IBOutlet weak var viewUiView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewUiView.layer.cornerRadius = 5
        viewUiView.backgroundColor = UIColor(red: 203/255, green: 206/255, blue: 199/255, alpha: 1.0)

        viewUiView.layer.shadowColor = UIColor.black.cgColor
        viewUiView.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewUiView.layer.shadowOpacity = 0.7
        viewUiView.layer.shadowRadius = 4.0
        
        enterEmailLabel.textColor = UIColor(red: 46/255, green: 80/255, blue: 107/255, alpha: 1.0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func validateField() -> String? {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter an email address"
        }
    
        return nil
    }
    

    @IBAction func resetPasswordButtonTapped(_ sender: Any) {
        
        let errorMessage = validateField()
        if errorMessage != nil {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let email = emailTextField.text!
        var user = ""
        if email.lowercased().contains("@med.com") {
            user = "is a doctor"
        } else {
            user = "is a patient"
        }
        
        if user == "is a doctor" {
            doctorViewModel.resetPassword(email: email, onSuccess: {
                
                let alert = UIAlertController(title: "", message: "Enter your email to reset your password", preferredStyle: UIAlertController.Style.alert)

                let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in
                    self.navigateToLoginPage()
                })
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
            }) {
                (errorMessage) in
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            }
        } else {
            patientViewModel.resetPassword(email: email, onSuccess: {
                let alert = UIAlertController(title: "", message: "Please check your email to reset your password", preferredStyle: UIAlertController.Style.alert)

                let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in
                    self.navigateToLoginPage()
                })
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
            }) {
                (errorMessage) in
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            }
        }
    }
    
    func navigateToLoginPage() {
        let loginPage = storyboard?.instantiateViewController(withIdentifier: "LoginPage") as? LoginViewController
        navigationController?.pushViewController(loginPage!, animated: true)
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigateToLoginPage()
    }
}
