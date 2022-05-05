
import UIKit

class PatientSearchViewController: UIViewController {
    
    var doctorSearch = true
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            doctorSearch = true
        }
        if sender.selectedSegmentIndex == 1 {
            doctorSearch = false
        }
    }
    
    
    @IBAction func selectDateButtonTapped(_ sender: Any) {
        let selectDateProfilePage = storyboard?.instantiateViewController(withIdentifier: "selectDateProfilePage") as? PatientSelectDateViewController
        
        selectDateProfilePage?.doctorSearch = doctorSearch
        selectDateProfilePage!.patient = patient
        navigationController?.pushViewController(selectDateProfilePage!, animated: true)
    }
    
    
}