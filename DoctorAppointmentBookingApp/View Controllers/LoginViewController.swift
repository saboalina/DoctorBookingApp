
import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var doctorViewModel = DoctorViewModel.shared
    var patientViewModel = PatientViewModel.shared
    var doctor : Doctor!
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                        print(err)
                    }
                })
            } else {
                self.errorLabel.text = "There was an error."
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
                        print(err)
                    }
                
                })
            } else {
                self.errorLabel.text = "There was an error."
            }
        }
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        
//        let email = "sabo.alina.99@gmail.com"
//        let password = "ananas123456"
        
//        let email = "maria@gmail.com"
//        let password = "maria1999"

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
        performSegue(withIdentifier: "toResetPasswordPage", sender: self)
//        let resetPasswordPage = storyboard?.instantiateViewController(withIdentifier: "toResetPasswordPage") as? ResetPasswordViewController
//
//        view.window?.rootViewController = resetPasswordPage
//        view.window?.makeKeyAndVisible()
    }
    
}
