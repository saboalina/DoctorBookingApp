
import UIKit
import MapKit

class PatientSearchViewController: UIViewController {
    
    var doctorSearch = true
    var patient: Patient!
    var filterViewModel = FiltersViewModel.shared
    
    @IBOutlet weak var checkAvailabilityLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var doctorsTableView: UITableView!
    var doctors: [Doctor] = []
    
    
    @IBOutlet weak var enterRadiusLabel: UILabel!
    @IBOutlet weak var selectAreaButton: UIButton!
    @IBOutlet weak var zoomIndexTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startDatePicker.datePickerMode = UIDatePicker.Mode.date
        startDatePicker.semanticContentAttribute = .forceRightToLeft
        endDatePicker.datePickerMode = UIDatePicker.Mode.date
        
        doctorsTableView.isHidden = false
        enterRadiusLabel.isHidden = true
        
        checkAvailabilityLabel.text = "Check doctors availability from date:"
        selectAreaButton.isHidden = true
        zoomIndexTextField.isHidden = true
        mapView.isHidden = true
        
        
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            checkAvailabilityLabel.text = "Check doctors availability from date:"
            doctorsTableView.isHidden = false
            enterRadiusLabel.isHidden = true
            doctorSearch = true
            selectAreaButton.isHidden = true
            zoomIndexTextField.isHidden = true
            mapView.isHidden = true
        }
        if sender.selectedSegmentIndex == 1 {
            checkAvailabilityLabel.text = "Check medical centers availability from date:"
            doctorsTableView.isHidden = true
            enterRadiusLabel.isHidden = false
            doctorSearch = false
            selectAreaButton.isHidden = false
            zoomIndexTextField.isHidden = false
            mapView.isHidden = false
        }
    }
    
    
    @IBAction func selectDateButtonTapped(_ sender: Any) {
        let selectDateProfilePage = storyboard?.instantiateViewController(withIdentifier: "selectDateProfilePage") as? PatientSelectDateViewController
        
        selectDateProfilePage?.doctorSearch = doctorSearch
        selectDateProfilePage!.patient = patient
        navigationController?.pushViewController(selectDateProfilePage!, animated: true)
    }
    
    
    @IBAction func checkAvailabilityButtonTapped(_ sender: Any) {
        
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        if doctorSearch == true {
            doctors = filterViewModel.getAvailableDoctors(startDate: startDate, endDate: endDate)
            doctorsTableView.reloadData()
            //performSegue(withIdentifier: "fromSearchToDoctorsList", sender: doctorsList)
        }
        else {
            let medicaCentersList = filterViewModel.getAvailableMedicalCenters(startDate: startDate, endDate: endDate)
            performSegue(withIdentifier: "fromSearchToMedicalCentersList", sender: medicaCentersList)
        }

    }
    

    @IBAction func selectAreaButtonTapped(_ sender: Any) {
        let zoomIndex = Int(zoomIndexTextField.text ?? "2000")
        performSegue(withIdentifier: "fromSearchToMapPage", sender: zoomIndex)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                
        if segue.identifier == "fromSearchToMapPage" {
            if let mapPage = segue.destination as? PatientMapViewController {
                mapPage.zoomIndex =  sender as! Int
                mapPage.patient = patient
            }
        }
        
        if segue.identifier == "fromSearchToMedicalCentersList" {
            if let fromSearchToMedicalCentersList = segue.destination as? PatientMedicalCentersListViewController {
                fromSearchToMedicalCentersList.medicalCenters =  sender as! [MedicalCenter]
                fromSearchToMedicalCentersList.patient = patient
            }
        }
        
        if segue.identifier == "fromSearchToDoctorDetailsPage" {
            if let doctorDetailsViewConntroller = segue.destination as? PatientDoctorDetailsViewController {
                doctorDetailsViewConntroller.doctor =  sender as! Doctor
                doctorDetailsViewConntroller.patient = patient
            }
        }
        
    }
    
}


extension PatientSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorVerticalViewCell") as! DoctorVerticalViewCell
        cell.nameLabel.text = "Dr. \(doctors[indexPath.row].name)"
        cell.serviceLabel.text = "\(doctors[indexPath.row].service) Specialist"
        cell.experienceLabel.text = "Experience: \(doctors[indexPath.row].experience)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doctor = doctors[indexPath.row]
        performSegue(withIdentifier: "fromSearchToDoctorDetailsPage", sender: doctor)
    }
    
}


