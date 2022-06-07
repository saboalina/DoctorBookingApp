
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
        
        doctorsTableView.isHidden = true
        checkAvailabilityLabel.text = "Check doctors availability from date:"
        selectAreaButton.isHidden = true
        zoomIndexTextField.isHidden = true
        mapView.isHidden = true
        
        if doctors.count > 0 {
            enterRadiusLabel.isHidden = false
            enterRadiusLabel.text = "Available Doctors"
            enterRadiusLabel.textColor = Colors.darkBlue
        }
        
        setDesign()
    }
    
    func setDesign() {
        view.backgroundColor = Colors.brown
        doctorsTableView.backgroundColor = Colors.brown
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            checkAvailabilityLabel.text = "Check doctors availability from:"
            doctorSearch = true
            enterRadiusLabel.text = ""
            if doctors.count > 0 {
                enterRadiusLabel.isHidden = false
                enterRadiusLabel.text = "Available Doctors"
                enterRadiusLabel.textColor = Colors.darkBlue
                doctorsTableView.isHidden = false
            } else {
                doctorsTableView.isHidden = true
            }
            selectAreaButton.isHidden = true
            zoomIndexTextField.isHidden = true
            mapView.isHidden = true
            mapView.layer.cornerRadius = 10
        }
        if sender.selectedSegmentIndex == 1 {
            checkAvailabilityLabel.text = "Check medical centers availability from:"
            doctorsTableView.isHidden = true
            enterRadiusLabel.isHidden = false
            enterRadiusLabel.text = "Enter the radius you want to search:"
            enterRadiusLabel.textColor = Colors.darkBlue
            doctorSearch = false
            selectAreaButton.isHidden = false
            zoomIndexTextField.isHidden = false
            mapView.isHidden = false
        }
    }
        
    @IBAction func checkAvailabilityButtonTapped(_ sender: Any) {
        
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        if doctorSearch == true {
            doctors = filterViewModel.getAvailableDoctors(startDate: startDate, endDate: endDate)
            doctorsTableView.reloadData()
            
            if doctors.count > 0 {
                enterRadiusLabel.isHidden = false
                enterRadiusLabel.text = "Available Doctors"
                enterRadiusLabel.textColor = Colors.darkBlue
                doctorsTableView.isHidden = false
            } else {
                doctorsTableView.isHidden = true
            }

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
                mapPage.zoomIndex =  sender as? Int ?? 2000
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
        return doctors.count > 2 ? 2 : self.doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorVerticalViewCell") as! DoctorVerticalViewCell
        cell.nameLabel.text = "Dr. \(doctors[indexPath.row].name)"
        cell.serviceLabel.text = "\(doctors[indexPath.row].service) Specialist"
        cell.experienceLabel.text = "Experience: \(doctors[indexPath.row].experience)"
        
        if let profilePictureURL = doctors[indexPath.row].imageURL {
            let url = NSURL(string: profilePictureURL)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    return
                }
                DispatchQueue.main.sync {
                    cell.profileImageView.image  = UIImage(data: data!)
                    cell.profileImageView.contentMode = .scaleAspectFill
                }
            }).resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 20, dy: 10)
        
        maskLayer.shadowColor = UIColor.black.cgColor
        maskLayer.shadowOffset = CGSize(width: 3, height: 3)
        maskLayer.shadowOpacity = 0.3
        maskLayer.shadowRadius = 4.0
        
        cell.layer.mask = maskLayer
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doctor = doctors[indexPath.row]
        performSegue(withIdentifier: "fromSearchToDoctorDetailsPage", sender: doctor)
    }
    
}


