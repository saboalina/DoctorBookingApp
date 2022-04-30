
import UIKit

class PatientDoctorDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var servicesAtLabel: UITextField!
    @IBOutlet weak var patientNumberLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var consultanceFeeLabel: UILabel!
    
    
    var doctor: Doctor!
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabels()
        print("in PatientDoctorDetailsViewController \(patient)")
    }
    
    func setLabels() {
        nameLabel.text = doctor.name
        emailLabel.text = doctor.email
        phoneLabel.text = doctor.phoneNumber
        serviceLabel.text = doctor.service
        servicesAtLabel.text = doctor.worksAt
        patientNumberLabel.text = doctor.numberOfPatients
        experienceLabel.text = doctor.experience
        consultanceFeeLabel.text = doctor.consultancyFee

    }
    
    
    @IBAction func bookAnAppointmentButtonTapped(_ sender: Any) {
        print("in booking \(patient)")
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
    
}
