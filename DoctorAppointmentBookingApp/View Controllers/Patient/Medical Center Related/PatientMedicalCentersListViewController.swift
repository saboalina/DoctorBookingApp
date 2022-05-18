import UIKit

class PatientMedicalCentersListViewController: UIViewController {
    
    
    @IBOutlet weak var medicalCenterTableView: UITableView!
    var patient: Patient!
    
    var medicalCenters: [MedicalCenter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.brown
        medicalCenterTableView.backgroundColor = Colors.brown
        
        setDesign()
    }
    

    func setDesign() {
        
        title = "Medical Centers"
        view.backgroundColor = Colors.brown
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.darkBlue]
                
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
        
        if let profilePictureURL = medicalCenters[indexPath.row].imageURL {
            let url = NSURL(string: profilePictureURL)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    return
                }
                DispatchQueue.main.async {
                    cell.logoImageView.image  = UIImage(data: data!)
                }
            }).resume()
        }
        
        cell.nameLabel.textColor = Colors.darkBlue
        cell.addressLabel.textColor = Colors.darkBlue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
        
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
