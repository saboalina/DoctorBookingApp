
import UIKit

class PatientSearchViewController: UIViewController {
    
    var doctorSearch = true
    var patient: Patient!
    
    @IBOutlet weak var zoomIndexTextField: UITextField!
    
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
        
    }
    
}

