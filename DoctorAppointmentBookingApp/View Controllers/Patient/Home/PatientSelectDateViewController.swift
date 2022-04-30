import UIKit

class PatientSelectDateViewController: UIViewController {

    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    var doctorSearch: Bool!
    var patient: Patient!
    
    var filterViewModel = FiltersViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        filterViewModel.doctorSearch = doctorSearch
        startDatePicker.datePickerMode = UIDatePicker.Mode.date
        endDatePicker.datePickerMode = UIDatePicker.Mode.date
        
    }
    

    @IBAction func filterButtonTapped(_ sender: Any) {
        
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        if doctorSearch == true {
            let doctorsList = filterViewModel.getAvailableDoctors(startDate: startDate, endDate: endDate)
            performSegue(withIdentifier: "fromSearchToDoctorsList", sender: doctorsList)
        } else {
            let medicaCentersList = filterViewModel.getAvailableMedicalCenters(startDate: startDate, endDate: endDate)
            performSegue(withIdentifier: "fromSearchToMedicalCentersList", sender: medicaCentersList)
        }

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSearchToDoctorsList" {
            if let fromMedicalDetailsToDoctorsList = segue.destination as? PatientDoctorsListViewController {
                fromMedicalDetailsToDoctorsList.doctors =  sender as! [Doctor]
                fromMedicalDetailsToDoctorsList.patient = patient
            }
        }
        
        if segue.identifier == "fromSearchToMedicalCentersList" {
            if let fromSearchToMedicalCentersList = segue.destination as? PatientMedicalCentersListViewController {
                fromSearchToMedicalCentersList.medicalCenters =  sender as! [MedicalCenter]
                fromSearchToMedicalCentersList.patient = patient
            }
        }
    }
    

}
