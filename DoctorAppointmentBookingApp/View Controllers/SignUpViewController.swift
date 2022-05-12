
import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!    
    @IBOutlet weak var viewUIView: UIView!
    @IBOutlet weak var alreadyHaveAnAccountLabel: UILabel!
    
    var doctorViewModel = DoctorViewModel.shared
    var patientViewModel = PatientViewModel.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewUIView.layer.cornerRadius = 5
        viewUIView.backgroundColor = UIColor(red: 203/255, green: 206/255, blue: 199/255, alpha: 1.0)

        viewUIView.layer.shadowColor = UIColor.black.cgColor
        viewUIView.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewUIView.layer.shadowOpacity = 0.7
        viewUIView.layer.shadowRadius = 4.0
        
        alreadyHaveAnAccountLabel.textColor = UIColor(red: 46/255, green: 80/255, blue: 107/255, alpha: 1.0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func validateFields() -> String? {
        
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter a name"
        }
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter an email address"
        }
        
        if phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter a phone number"
        } else {
            let phoneNumberString = phoneNumberTextField.text ?? "0"
            for digit in phoneNumberString {
                let isInt = digit.isNumber
                if !isInt {
                    return "Please enter a valid phone number -> nu e nr"
                }
            }
            if phoneNumberString.count != 10 {
                return "Please enter a valid phone number -> nu are 10 "
            }
        }
        
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter a password"
        }
    
        if confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please confirm the password"
        }
        
        if passwordTextField.text != confirmPasswordTextField.text {
            return "Please make sure your passwords match"
        }
    
        return nil
    }
    
    func verifyUser(email: String) -> String {
        var user = ""

        if email.lowercased().contains("@med.com") {
            user = "is a doctor"
        } else {
            user = "is a patient"
        }
        
        return user
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let error = validateFields()
        
        let errorMessage = validateFields()
        if errorMessage != nil {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
                    
            let email = self.emailTextField.text ?? ""
            let name = self.nameTextField.text ?? ""
            let phoneNumber = self.phoneNumberTextField.text ?? ""
            let password = self.passwordTextField.text ?? ""
            
            let userType = verifyUser(email: email)
            
            if userType == "is a patient" {
                
                let patient = Patient(email: email, password: password, name: name, phoneNumber: phoneNumber, history: "", id: "")
                
                patientViewModel.createUser(patient: patient) {[weak self] (success) in
                    guard let `self` = self else { return }
                    if (success) {
                        let alert = UIAlertController(title: "Success", message: "Your account is created!", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in self.performSegue(withIdentifier: "loadLoginPage", sender: self)})
                        alert.addAction(okAction)
                        self.present(alert, animated: true)
                        
                        //self.performSegue(withIdentifier: "loadLoginPage", sender: self)
                    } else {
                        let alert = UIAlertController(title: "Error", message: "There was an error.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            } else {
                
                let doctor = Doctor(email: email, password: password, name: name, phoneNumber: phoneNumber, worksAt: "", numberOfPatients: "", experience: "", consultancyFee: "", service: "", id: "",
                                    sun: "", mon: "", tue: "", wed: "", thu: "", fri: "", sat: "")
                
                doctorViewModel.createUser(doctor: doctor) {[weak self] (errorCode) in
                    guard let `self` = self else { return }
                    if let err = errorCode {
                        let alert = UIAlertController(title: "Error", message: "There was an error.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                                                
                        let alert = UIAlertController(title: "Success", message: "Your account is created!", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in self.performSegue(withIdentifier: "loadLoginPage", sender: self)})
                        alert.addAction(okAction)
                        self.present(alert, animated: true)

                    }
                }
            }
                                
            
        }

    }
        
    func transitionToHome() {
        
        let loginPage = storyboard?.instantiateViewController(withIdentifier: "LoginPage") as? LoginViewController
     
//        view.window?.rootViewController = loginPage
//        view.window?.makeKeyAndVisible()
        navigationController?.pushViewController(loginPage!, animated: true)

    }
    
    
    
    @IBAction func alreadyHaveAnAcoountButtonTapped(_ sender: Any) {
        self.transitionToHome()
        
    }
    
}
