
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
    
    var doctor : Doctor!
    var patient: Patient!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewUIView.layer.cornerRadius = 5
        viewUIView.backgroundColor = Colors.brown

        viewUIView.layer.shadowColor = UIColor.black.cgColor
        viewUIView.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewUIView.layer.shadowOpacity = 0.7
        viewUIView.layer.shadowRadius = 4.0
        
        alreadyHaveAnAccountLabel.textColor = Colors.darkBlue

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
                    return "Please enter a valid phone number"
                }
            }
            if phoneNumberString.count != 10 {
                return "Please enter a valid phone number"
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
                
                let patient = Patient(email: email, password: password, name: name, phoneNumber: phoneNumber, history: "", id: "", imageURL: "https://firebasestorage.googleapis.com/v0/b/doctor-appointment-booki-5017b.appspot.com/o/patients%2FScreenshot%202022-05-17%20at%2010.27.39.png?alt=media&token=74ee29bc-c180-4643-bb1a-e3717bb47522")
                
                patientViewModel.createUser(patient: patient) {[weak self] (success) in
                    guard let `self` = self else { return }
                    if (success) {

                        let alert = UIAlertController(title: "Success", message: "Your account is created!", preferredStyle: .alert)

                        if userType == "is a patient" {
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in
                                self.signUpAsPatient(email: email, password: password)
                            })
                            alert.addAction(okAction)
                            self.present(alert, animated: true)
                            
                        } else {
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in
                                self.signUpAsDoctor(email: email, password: password)
                                
                            })
                            alert.addAction(okAction)
                            self.present(alert, animated: true)
                            
                        }
                        
                    } else {
                        let alert = UIAlertController(title: "Error", message: "There was an error.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            } else {
                
                let doctor = Doctor(email: email, password: password, name: name, phoneNumber: phoneNumber, worksAt: "", numberOfPatients: "", experience: "", consultancyFee: "", service: "", id: "",
                                    sun: "", mon: "", tue: "", wed: "", thu: "", fri: "", sat: "", imageURL: "https://firebasestorage.googleapis.com/v0/b/doctor-appointment-booki-5017b.appspot.com/o/patients%2FScreenshot%202022-05-17%20at%2010.27.39.png?alt=media&token=74ee29bc-c180-4643-bb1a-e3717bb47522")
                
                doctorViewModel.createUser(doctor: doctor) {[weak self] (errorCode) in
                    guard let `self` = self else { return }
                    if errorCode != nil {
                        let alert = UIAlertController(title: "Error", message: "There was an error.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        
                        let alert = UIAlertController(title: "Success", message: "Your account is created!", preferredStyle: .alert)

                        if userType == "is a patient" {
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in
                                self.signUpAsPatient(email: email, password: password)
                            })
                            alert.addAction(okAction)
                            self.present(alert, animated: true)
                            
                        } else {
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in
                                self.signUpAsDoctor(email: email, password: password)
                                
                            })
                            alert.addAction(okAction)
                            self.present(alert, animated: true)
                            
                        }
                                                

                    }
                }
            }
                                
            
        }

    }
    
    func signUpAsDoctor(email: String, password: String) {
        
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
    
    func signUpAsPatient(email: String, password: String) {
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
    
    func transitionToHome() {
        
        let loginPage = storyboard?.instantiateViewController(withIdentifier: "LoginPage") as? LoginViewController
        navigationController?.pushViewController(loginPage!, animated: true)

    }
    
    
    
    @IBAction func alreadyHaveAnAcoountButtonTapped(_ sender: Any) {
        self.transitionToHome()
        
    }
    
}
