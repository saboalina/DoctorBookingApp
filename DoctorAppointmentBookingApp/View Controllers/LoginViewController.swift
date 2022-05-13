
import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var viewUiView: UIView!
    
    @IBOutlet weak var dontHaveAnAccountLabel: UILabel!
    var doctorViewModel = DoctorViewModel.shared
    var patientViewModel = PatientViewModel.shared
    var doctor : Doctor!
    var patient: Patient!
    
    var attrs = [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17.0),
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]

    var attributedString = NSMutableAttributedString(string:"")
    
    override func viewDidLoad() {
        super.viewDidLoad()
             
        setDesign()

    }
    
    func setDesign() {
        
        viewUiView.layer.cornerRadius = 5
        viewUiView.backgroundColor = Colors.brown

        viewUiView.layer.shadowColor = UIColor.black.cgColor
        viewUiView.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewUiView.layer.shadowOpacity = 0.7
        viewUiView.layer.shadowRadius = 4.0
        
        dontHaveAnAccountLabel.textColor = Colors.darkBlue
        
        let buttonTitleStr = NSMutableAttributedString(string:"Forgot password?", attributes:attrs)
        attributedString.append(buttonTitleStr)
        forgotPasswordButton.setAttributedTitle(attributedString, for: .normal)
        forgotPasswordButton.backgroundColor = Colors.brown
        forgotPasswordButton.tintColor = Colors.darkBlue
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    func loginAsDoctor(email: String, password: String) {
        
        doctorViewModel.login(email: email, pass: password) { [weak self] (success) in
            guard let `self` = self else { return }
            if (success) {
                self.doctorViewModel.getDoctorBy(email: email, handler: { res in
                    switch res{
                    case .success(let doctor):
                        self.doctor = doctor
                        self.navigateToDoctorPage(doctor: doctor)
                    case .failure(let err):
                        let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            } else {
                let alert = UIAlertController(title: "Error", message: "Email/Password combination is invalid!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    func loginAsPatient(email: String, password: String) {
        self.patientViewModel.login(email: email, pass: password) { [weak self] (success) in
            guard let `self` = self else { return }
            if (success) {
                self.patientViewModel.getPatientBy(email: email, handler: { res in
                    switch res{
                    case .success(let patient):
                        self.patient = patient
                        self.navigateToPatientPage(pacient: patient)
                    case .failure(let err):

                        let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                
                })
            } else {
                let alert = UIAlertController(title: "Error", message: "Email/Password combination is invalid!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func validateFields() -> String? {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter an email address"
        }
        
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter a password"
        }
    
        return nil
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
//        
//        let email = self.emailTextField.text!
//        let password = self.passwordTextField.text!
        
//        let email = "sabo.alina.99@gmail.com"
//        let password = "ananas123456"
        
//        let email = "niallshelton@med.com"
//        let password = "niallshelton1234"
        
        let email = "alina@yahoo.com"
        let password = "alina1999"
        
//        let errorMessage = validateFields()
//        if errorMessage != nil {
//            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }

        let userType = verifyUser(email: email)
        
        if userType == "is a patient" {
            loginAsPatient(email: email, password: password)
        } else {
            loginAsDoctor(email: email, password: password)
        }
        
    }
    
    func navigateToDoctorPage(doctor: Doctor) {
        let doctorPage = storyboard?.instantiateViewController(withIdentifier: "DoctorPage") as? DoctorPageViewController
        
        doctorPage?.doctor = doctor
     
        view.window?.rootViewController = doctorPage
        view.window?.makeKeyAndVisible()
    }
    
    func navigateToPatientPage(pacient: Patient) {
        let patientPage = storyboard?.instantiateViewController(withIdentifier: "PatientPage") as? PatientPageViewController
        
        patientPage?.patient = patient
     
        view.window?.rootViewController = patientPage
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func resetPasswordButtonTapped(_ sender: Any) {
        
        let resetPasswordPage = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordPage") as? ResetPasswordViewController

        navigationController?.pushViewController(resetPasswordPage!, animated: true)
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {

        
        let signUpPage = storyboard?.instantiateViewController(withIdentifier: "SignUpPage") as? SignUpViewController

        navigationController?.pushViewController(signUpPage!, animated: true)
    }
}
