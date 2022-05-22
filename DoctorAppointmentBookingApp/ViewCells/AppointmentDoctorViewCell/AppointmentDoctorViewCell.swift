
import UIKit

class AppointmentDoctorViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var doneButton: ButtonClassBlue!
    @IBOutlet weak var cancelButton: ButtonClassOrange!
    
    @IBOutlet weak var patientImageView: UIImageView!
    @IBOutlet weak var contentViewUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
