
import UIKit

class DoctorHorizontalViewCell: UICollectionViewCell {

   
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorServiceLabel: UILabel!
    @IBOutlet weak var doctorExperienceLabel: UILabel!
    @IBOutlet weak var doctorPatientsLabel: UILabel!
    
    
    static let identifier = String(describing: DoctorHorizontalViewCell.self)
    
    
    func setup(doctor: Doctor) {
        doctorNameLabel.text = doctor.name
        doctorServiceLabel.text = "\(doctor.service) Specialist"
        doctorExperienceLabel.text = doctor.experience
        doctorPatientsLabel.text = doctor.numberOfPatients
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0
        
    }
}
