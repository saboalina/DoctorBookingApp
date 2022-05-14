
import UIKit

class PatientMedicalCenterDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var monProgramLabel: UILabel!
    @IBOutlet weak var tueProgramLabel: UILabel!
    @IBOutlet weak var wedProgramLabel: UILabel!
    @IBOutlet weak var thuProgramLabel: UILabel!
    @IBOutlet weak var friProgramLabel: UILabel!
    @IBOutlet weak var satProgramLabel: UILabel!
    @IBOutlet weak var sunProgramLabel: UILabel!
    @IBOutlet weak var servicesTableView: UITableView!
    
    var medicalCenter: MedicalCenter!
    var patient: Patient!
    var filterViewModel = FiltersViewModel.shared
    
    var services: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        services = medicalCenter.services.components(separatedBy: ",")
        setLabels()
        view.backgroundColor = Colors.brown
        servicesTableView.backgroundColor = Colors.brown
        
    }
    
    func setLabels() {
        nameLabel.text = medicalCenter.name
        addressLabel.text = medicalCenter.address
        if medicalCenter.mon == "" {
            monProgramLabel.text = "Closed"
        } else {
            monProgramLabel.text = medicalCenter.mon
        }
        
        if medicalCenter.tue == "" {
            tueProgramLabel.text = "Closed"
        } else {
            tueProgramLabel.text = medicalCenter.tue
        }
        
        if medicalCenter.wed == "" {
            wedProgramLabel.text = "Closed"
        } else {
            wedProgramLabel.text = medicalCenter.wed
        }
        
        if medicalCenter.thu == "" {
            thuProgramLabel.text = "Closed"
        } else {
            thuProgramLabel.text = medicalCenter.thu
        }
        
        if medicalCenter.fri == "" {
            friProgramLabel.text = "Closed"
        } else {
            friProgramLabel.text = medicalCenter.fri
        }
        
        if medicalCenter.sat == "" {
            satProgramLabel.text = "Closed"
        } else {
            satProgramLabel.text = medicalCenter.sat
        }
        
        if medicalCenter.sun == "" {
            sunProgramLabel.text = "Closed"
        } else {
            sunProgramLabel.text = medicalCenter.sun
        }

    }


}

extension PatientMedicalCenterDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryOfMCViewCell") as! CategoryOfMCViewCell
        cell.serviceNameLabel.text = services[indexPath.row]
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = .zero
        cell.layer.cornerRadius = 8
        cell.layer.shadowOpacity = 0.1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = services[indexPath.row]
        let doctorsList = filterViewModel.getDoctorsByServiceWorkingAt(service: service, medicalCenterName: medicalCenter.name)
        performSegue(withIdentifier: "fromMedicalDetailsToDoctorsList", sender: doctorsList)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.white.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        maskLayer.shadowColor = UIColor.white.cgColor
        maskLayer.shadowOffset = CGSize(width: 3, height: 3)
        maskLayer.shadowOpacity = 0.9
        maskLayer.shadowRadius = 4.0
        
        cell.layer.mask = maskLayer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromMedicalDetailsToDoctorsList" {
            if let fromMedicalDetailsToDoctorsList = segue.destination as? PatientDoctorsListViewController {
                fromMedicalDetailsToDoctorsList.doctors =  sender as! [Doctor]
                fromMedicalDetailsToDoctorsList.patient = patient
            }
        }
    }
}
