

import UIKit

class DoctorEditProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var serviceTextField: UITextField!
    @IBOutlet weak var servicesAtTextField: UITextView!
    @IBOutlet weak var consultancyFeeTextField: UITextField!
    
    
    @IBOutlet weak var monTextField: UITextField!
    @IBOutlet weak var tueTextField: UITextField!
    @IBOutlet weak var wedTextField: UITextField!
    @IBOutlet weak var thuTextField: UITextField!
    @IBOutlet weak var friTextField: UITextField!
    @IBOutlet weak var satTextField: UITextField!
    @IBOutlet weak var sunTextField: UITextField!
    
    var doctorViewModel = DoctorViewModel.shared
    var doctor: Doctor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        setDesign()
    }
    
    func setLabels() {
        nameTextField.text = doctor?.name
        phoneTextField.text = doctor?.phoneNumber
        serviceTextField.text = doctor?.service
        servicesAtTextField.text = doctor?.worksAt
        consultancyFeeTextField.text = doctor?.consultancyFee
        
        monTextField.text = doctor?.mon
        tueTextField.text = doctor?.tue
        wedTextField.text = doctor?.wed
        thuTextField.text = doctor?.thu
        friTextField.text = doctor?.fri
        satTextField.text = doctor?.sat
        sunTextField.text = doctor?.sun
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let name = nameTextField.text!
        let phoneNumber = phoneTextField.text!
        let service = serviceTextField.text!
        let worksAt = servicesAtTextField.text!
        let consultancyFee = consultancyFeeTextField.text!
        
        let mon = monTextField.text!
        let tue = tueTextField.text!
        let wed = wedTextField.text!
        let thu = thuTextField.text!
        let fri = friTextField.text!
        let sat = satTextField.text!
        let sun = sunTextField.text!
        
        doctorViewModel.updateDoctor(doctorId: doctor!.id, name: name, phoneNumber: phoneNumber, service: service, worksAt: worksAt, consultancyFee: consultancyFee, mon: mon, tue: tue, wed: wed, thu: thu, fri: fri, sat: sat, sun: sun) { success in
            if success {
                self.navigateToDoctorProfile()
            } else {
                let alert = UIAlertController(title: "Error", message: "There was an error!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
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

        servicesAtTextField.layer.shadowColor = UIColor.black.cgColor
        servicesAtTextField.layer.cornerRadius = 10
                
    }
    
    func navigateToDoctorProfile() {
        navigationController?.popViewController(animated: true)
    }

}
