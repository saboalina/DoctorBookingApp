import UIKit

class PatientMedicalCentersListViewController: UIViewController {
    
    
    @IBOutlet weak var medicalCenterTableView: UITableView!
    var patient: Patient!
    
    var medicalCenters: [MedicalCenter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}

extension PatientMedicalCentersListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicalCenters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalCenterVerticalViewCell") as! MedicalCenterVerticalViewCell
        cell.nameLabel.text = medicalCenters[indexPath.row].name
        cell.addressLabel.text = medicalCenters[indexPath.row].address
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let medicalCenter = medicalCenters[indexPath.row]
        performSegue(withIdentifier: "fromMCListToMCDetails", sender: medicalCenter)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromMCListToMCDetails" {
            if let medicalCenterDetailsViewConntroller = segue.destination as? PatientMedicalCenterDetailsViewController {
                medicalCenterDetailsViewConntroller.medicalCenter =  sender as! MedicalCenter
                medicalCenterDetailsViewConntroller.patient = patient
            }
        }
        
    }
}
