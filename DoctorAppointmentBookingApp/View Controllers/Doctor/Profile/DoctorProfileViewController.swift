

import UIKit
import Firebase

class DoctorProfileViewController: UIViewController {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var servicesAtTextView: UITextView!
    @IBOutlet weak var patientNumberLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var consultanceFeeLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    @IBOutlet weak var serviceAt: UILabel!
    @IBOutlet weak var patients: UILabel!
    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var consulanceFee: UILabel!
    
    @IBOutlet weak var monLabel: UILabel!
    @IBOutlet weak var tueLabel: UILabel!
    @IBOutlet weak var wedLabel: UILabel!
    @IBOutlet weak var thuLabel: UILabel!
    @IBOutlet weak var friLabel: UILabel!
    @IBOutlet weak var satLabel: UILabel!
    @IBOutlet weak var sunLabel: UILabel!
    
    var doctorViewModel = DoctorViewModel.shared
    var doctor: Doctor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        setDesign()
    }
    
    func setDesign() {
        
        
        title = "My Profile"
        view.backgroundColor = Colors.brown
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.darkBlue]

        servicesAtTextView.layer.shadowColor = UIColor.black.cgColor
        servicesAtTextView.layer.cornerRadius = 10
        
        nameLabel.textColor = Colors.darkBlue
        emailLabel.textColor = Colors.white
        phoneLabel.textColor = Colors.white
        serviceLabel.textColor = Colors.white
        patientNumberLabel.textColor = Colors.white
        experienceLabel.textColor = Colors.white
        consultanceFeeLabel.textColor = Colors.white
        
        serviceAt.textColor = Colors.darkBlue
        patients.textColor = Colors.darkBlue
        experience.textColor = Colors.darkBlue
        consulanceFee.textColor = Colors.darkBlue
        servicesAtTextView.textColor = Colors.darkBlue
                
        monLabel.textColor = Colors.white
        tueLabel.textColor = Colors.white
        wedLabel.textColor = Colors.white
        thuLabel.textColor = Colors.white
        friLabel.textColor = Colors.white
        satLabel.textColor = Colors.white
        sunLabel.textColor = Colors.white
    }
    
    func setLabels() {
        nameLabel.text = doctor.name
        emailLabel.text = doctor.email
        phoneLabel.text = doctor.phoneNumber
        serviceLabel.text = "\(doctor.service) Specialist"
        servicesAtTextView.text = doctor.worksAt
        patientNumberLabel.text = doctor.numberOfPatients
        experienceLabel.text = doctor.experience
        consultanceFeeLabel.text = doctor.consultancyFee
        
        monLabel.text = doctor.mon
        tueLabel.text = doctor.tue
        wedLabel.text = doctor.wed
        thuLabel.text = doctor.thu
        friLabel.text = doctor.fri
        satLabel.text = doctor.sat
        sunLabel.text = doctor.sun

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.doctorViewModel.getDoctorBy(email: doctor!.email, handler: { res in
            switch res{
            case .success(let doctor):
                self.doctor = doctor
                self.setLabels()
            case .failure(let err):
                print(err)
            }

        })
        
        
    }
    

    @IBAction func logoutButtonTapped(_ sender: Any) {
                
        let firstPage = storyboard?.instantiateInitialViewController()
     
        view.window?.rootViewController = firstPage
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        let editDoctorProfilePage = storyboard?.instantiateViewController(withIdentifier: "editDoctorProfilePage") as? DoctorEditProfileViewController
        
        editDoctorProfilePage?.doctor = doctor
     
        navigationController?.pushViewController(editDoctorProfilePage!, animated: true)
    }
}
