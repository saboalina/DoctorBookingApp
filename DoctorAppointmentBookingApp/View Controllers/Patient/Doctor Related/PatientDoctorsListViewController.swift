
import UIKit

class PatientDoctorsListViewController: UIViewController {
    
    
    @IBOutlet weak var doctorsTableView: UITableView!
    var patient: Patient!
    var doctors: [Doctor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.brown
        doctorsTableView.backgroundColor = Colors.brown
        
        setDesign()
    }
    
    func setDesign() {
        
        
        title = "Our Doctors"
        view.backgroundColor = Colors.brown
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.darkBlue]
                
    }

}

extension PatientDoctorsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
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
                DispatchQueue.main.async {
                    cell.profile2ImageView.image  = UIImage(data: data!)
                    cell.profile2ImageView.contentMode = .scaleAspectFill
                }
            }).resume()
        }
        
        cell.nameLabel.textColor = Colors.darkBlue
        cell.serviceLabel.textColor = Colors.darkBlue
        cell.experienceLabel.textColor = Colors.darkBlue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doctor = doctors[indexPath.row]
        performSegue(withIdentifier: "fromDoctorListToDoctorDetails", sender: doctor)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromDoctorListToDoctorDetails" {
            if let doctorDetailsViewConntroller = segue.destination as? PatientDoctorDetailsViewController {
                doctorDetailsViewConntroller.doctor =  sender as! Doctor
                doctorDetailsViewConntroller.patient = patient
            }
        }
        
    }
    
}
