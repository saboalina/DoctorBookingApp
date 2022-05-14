

import UIKit
import FirebaseFirestore

class DoctorAppointmentsViewController: UIViewController {

    
    @IBOutlet weak var appointmentsTableView: UITableView!
    var doctorViewModel = DoctorViewModel.shared
    var appointmentViewModel = AppointmentViewModel.shared
    var patientViewModel = PatientViewModel.shared
    
    var doctor: Doctor!
        
    private var allAppointments = [Appointment]() {
        didSet {
            DispatchQueue.main.async {
                self.appointments = self.allAppointments
            }
        }
    }
        
    var appointments = [Appointment]() {
        didSet {
            DispatchQueue.main.async {
                self.appointmentsTableView.reloadData()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(appointmentsTableView)
        appointmentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        appointmentsTableView.dataSource = self
        appointmentsTableView.delegate = self
        
        loadData()
        
        setDesign()

    }
        
    func setDesign() {
        
        
        title = "My Appointments"
        view.backgroundColor = Colors.brown
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.darkBlue]

        appointmentsTableView.backgroundColor = Colors.brown
                
    }
    
    
    func loadData() {
        appointmentViewModel.getAllAppointmentsForADoctor(collectionID: "appointments", doctorEmail: doctor.email) { appointments in
                self.appointments = appointments
        }
    }

}

extension DoctorAppointmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentDoctorViewCell") as! AppointmentDoctorViewCell
        
        cell.dateLabel.text = appointments[indexPath.row].date
        cell.timeLabel.text = appointments[indexPath.row].time
        
        self.patientViewModel.getPatientBy(email: appointments[indexPath.row].patientId, handler: { res in
            switch res{
            case .success(let patient):
                cell.nameLabel.text = patient.name
                cell.nameLabel.textColor = Colors.darkBlue
                cell.dateLabel.textColor = Colors.darkBlue
                cell.timeLabel.textColor = Colors.darkBlue
            case .failure(let err):
                print(err)
            }
        })
        
        cell.doneButton.addTarget(self, action: #selector(deleteAppointment(sender:)), for: .touchUpInside)
        cell.cancelButton.addTarget(self, action: #selector(deleteAppointment(sender:)), for: .touchUpInside)
        
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
    
    
    @objc
    func deleteAppointment(sender: UIButton){
        let rowIndex = sender.tag
        //do something
        print(rowIndex)
        print(appointments[rowIndex].doctorId)
        
        appointmentViewModel.deleteAppointment(appointment: appointments[rowIndex]) { [weak self] (success) in
            guard let `self` = self else { return }
            if (success) {
                self.appointmentsTableView.reloadData()
            } else {
                print("There was an error.")
            }
        }
    }
    
}
