
import UIKit

class PatientDoctorDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var servicesAtLabel: UITextView!
    @IBOutlet weak var patientNumberLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var consultanceFeeLabel: UILabel!
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var monLabel: UILabel!
    @IBOutlet weak var tueLabel: UILabel!
    @IBOutlet weak var wedLabel: UILabel!
    @IBOutlet weak var thuLabel: UILabel!
    @IBOutlet weak var friLabel: UILabel!
    @IBOutlet weak var satLabel: UILabel!
    @IBOutlet weak var sunLabel: UILabel!
    
    var doctor: Doctor!
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabels()
        setProfilePicture()
        setDesign()
    }
    
    func setLabels() {
        nameLabel.text = doctor.name
        emailLabel.text = doctor.email
        phoneLabel.text = doctor.phoneNumber
        serviceLabel.text = "\(doctor.service) Specialist"
        servicesAtLabel.text = doctor.worksAt
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
    
    func setDesign() {
        
        view.backgroundColor = Colors.brown
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.darkBlue]

        servicesAtLabel.layer.shadowColor = UIColor.black.cgColor
        servicesAtLabel.layer.cornerRadius = 10
        
        nameLabel.textColor = Colors.darkBlue
        emailLabel.textColor = Colors.white
        phoneLabel.textColor = Colors.white
        serviceLabel.textColor = Colors.white
        patientNumberLabel.textColor = Colors.white
        experienceLabel.textColor = Colors.white
        consultanceFeeLabel.textColor = Colors.white
        
//        serviceAt.textColor = Colors.darkBlue
//        patients.textColor = Colors.darkBlue
//        experience.textColor = Colors.darkBlue
//        consulanceFee.textColor = Colors.darkBlue
        servicesAtLabel.textColor = Colors.darkBlue
                
        monLabel.textColor = Colors.white
        tueLabel.textColor = Colors.white
        wedLabel.textColor = Colors.white
        thuLabel.textColor = Colors.white
        friLabel.textColor = Colors.white
        satLabel.textColor = Colors.white
        sunLabel.textColor = Colors.white
    }
    
    @IBAction func bookAnAppointmentButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromDoctorDetailstoBookApp", sender: doctor)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromDoctorDetailstoBookApp" {
            if let fromDoctorDetailstoBookApp = segue.destination as? PatientBookAnAppointmentViewController {
                fromDoctorDetailstoBookApp.doctor =  sender as! Doctor
                fromDoctorDetailstoBookApp.patient = patient
            }
        }
        
    }
    
    func setProfilePicture() {
        if let profilePictureURL = doctor.imageURL {
            let url = NSURL(string: profilePictureURL)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    return
                }
                DispatchQueue.main.sync {
                    self.profilePictureImageView.image  = UIImage(data: data!)
                    self.profilePictureImageView.contentMode = .scaleAspectFill
                }
            }).resume()
        }
    }
    
}
