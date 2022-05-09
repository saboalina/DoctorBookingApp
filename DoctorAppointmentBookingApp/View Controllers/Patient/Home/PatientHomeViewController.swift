
import UIKit
import Firebase
import UserNotifications

class PatientHomeViewController: UIViewController {
    
    
    @IBOutlet weak var doctorCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var medicalCenterCollectionView: UICollectionView!
    
    
    var doctorViewModel = DoctorViewModel.shared
    var medicalCenterViewModel = MedicalCenterViewModel()
    var appointmentViewModel = AppointmentViewModel()
    var filterViewModel = FiltersViewModel.shared
    
    var patient: Patient!
    
    private var allDoctors = [Doctor]() {
        didSet {
            DispatchQueue.main.async {
                self.doctors = self.allDoctors
            }
        }
    }

    var doctors = [Doctor]() {
        didSet {
            DispatchQueue.main.async {
                self.doctorCollectionView.reloadData()
            }
        }
    }
    
    private var allMedicalCenters = [MedicalCenter]() {
        didSet {
            DispatchQueue.main.async {
                self.medicalCenters = self.allMedicalCenters
            }
        }
    }

    var medicalCenters = [MedicalCenter]() {
        didSet {
            DispatchQueue.main.async {
                self.medicalCenterCollectionView.reloadData()
            }
        }
    }
    
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
                //self.appointmentsTableView.reloadData()
                self.checkDates()
            }
        }
    }
    
    let categories = ["Dermathology", "Endocrinology", "Ultrasound", "Dermathology", "Psychology", "Plastic surgery", "Nutrition", "Cardiology", "Ophthalmology", "Neurology", "Paediatrics", "Psychiatry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        registerCell()
        
        print("in PatientHomeViewController \(patient.name)")
    }

    func loadData() {
        doctorViewModel.getAllDoctors(collectionID: "doctors") { doctors in
                self.doctors = doctors
        }

        medicalCenterViewModel.getAllMedicalCenters(collectionID: "medicalCenters") { medicalCenters in
                self.medicalCenters = medicalCenters
        }
        
        appointmentViewModel.getAllAppointmentsForAPatient(collectionID: "appointments", patientEmail: patient.email) { appointments in
                self.appointments = appointments
        }

    }
    
    private func registerCell() {
        doctorCollectionView.register(
            UINib(nibName: DoctorHorizontalViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DoctorHorizontalViewCell.identifier)
        
        categoriesCollectionView.register(
            UINib(nibName: CategoriesViewCell.identifier, bundle: nil), forCellWithReuseIdentifier:
                CategoriesViewCell.identifier)
        
        
        medicalCenterCollectionView.register(
            UINib(nibName: MedicalCenterHorizontalViewCell.identifier, bundle: nil), forCellWithReuseIdentifier:
                MedicalCenterHorizontalViewCell.identifier)
        
        
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "SearchPage", sender: nil)
    }
    
    func checkDates() {
        for appointment in appointments {
            print("-----> \(appointment.date)")
            let stringDate = appointment.date
            let dateInfo = stringDate.components(separatedBy: "-")
            let appointmentYear = Int(dateInfo[0])
            let appointmentMonth = Int(dateInfo[1])
            let appointmentDay = Int(dateInfo[2])
                        
            let date = Date().addingTimeInterval(86400)
            let calendar = Calendar.current

            let currentDateYear = calendar.component(.year, from: date)
            let currentDateMonth = calendar.component(.month, from: date)
            let currentDateDay = calendar.component(.day, from: date)


            if currentDateYear == appointmentYear && currentDateMonth == appointmentMonth && currentDateDay == appointmentDay {
                print("programare maine")
                getNotification(appointment: appointment)
            }
        }
    }
    
    
    func getNotification(appointment: Appointment) {
        
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Appointment tomorrow"
        content.body = "You have an appointment for tomorrow at \(appointment.time). Check your appointments list!"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "yourIdentifier"
        content.userInfo = ["example": "information"] // You can retrieve this when displaying notification
        
        let date = convertDate(date: Date() + 5)
                
        let trigger = UNCalendarNotificationTrigger(dateMatching: date as DateComponents, repeats: false)
        
        // Create request
        let uniqueID = UUID().uuidString // Keep a record of this if necessary
        let request = UNNotificationRequest(identifier: uniqueID, content: content, trigger: trigger)
        center.add(request) // Add the notification request
    }
    
    func convertDate(date: Date) -> NSDateComponents {
        print(date)

        let calendar = Calendar.current

        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)

        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let sec = calendar.component(.second, from: date)

        let newDate = NSDateComponents()

        print("\(year):\(month):\(day)" + " " + "\(hour):\(minutes):\(sec)")

        newDate.timeZone = TimeZone.current

        newDate.hour = hour
        newDate.minute = minutes
        newDate.second = sec

        newDate.day = day
        newDate.month = month
        newDate.year = year

        print("\(newDate.year):\(newDate.month):\(newDate.day)" + " " + "\(newDate.hour):\(newDate.minute):\(newDate.second) zone:\(TimeZone.current)")

        return newDate
    }
}

extension PatientHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.doctorCollectionView {
            return doctors.count
        }
        if collectionView == self.categoriesCollectionView {
            return categories.count
        }
        return medicalCenters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.doctorCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorHorizontalViewCell.identifier, for: indexPath) as! DoctorHorizontalViewCell
            cell.setup(doctor: doctors[indexPath.row])
            return cell
        }
        if collectionView == self.categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesViewCell.identifier, for: indexPath) as! CategoriesViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicalCenterHorizontalViewCell.identifier, for: indexPath) as! MedicalCenterHorizontalViewCell
        cell.setup(medicalCenter: medicalCenters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.doctorCollectionView {
            let doctor = doctors[indexPath.row]
            performSegue(withIdentifier: "showDoctorDetails", sender: doctor)

        }
        
        if collectionView == self.categoriesCollectionView {
            let service = categories[indexPath.row]
            let medicaCentersList = filterViewModel.getMedicalCentersByService(service: service)
            performSegue(withIdentifier: "fromHomeToMedicalCentersList", sender: medicaCentersList)
        }
        
        if collectionView == self.medicalCenterCollectionView {
            let medicalCenter = medicalCenters[indexPath.row]
            performSegue(withIdentifier: "showMedicalCenterDetails", sender: medicalCenter)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SearchPage" {
            if let searchPage = segue.destination as? PatientSearchViewController {
                searchPage.patient = patient
            }
        }
        
        if segue.identifier == "showDoctorDetails" {
            if let doctorDetailsViewConntroller = segue.destination as? PatientDoctorDetailsViewController {
                doctorDetailsViewConntroller.doctor =  sender as! Doctor
                doctorDetailsViewConntroller.patient = patient
            }
        }
        
        if segue.identifier == "showMedicalCenterDetails" {
            if let medicalCenterDetailsViewConntroller = segue.destination as? PatientMedicalCenterDetailsViewController {
                medicalCenterDetailsViewConntroller.medicalCenter =  sender as! MedicalCenter
                medicalCenterDetailsViewConntroller.patient = patient
            }
        }
        
        if segue.identifier == "fromHomeToMedicalCentersList" {
            if let fromSearchToMedicalCentersList = segue.destination as? PatientMedicalCentersListViewController {
                fromSearchToMedicalCentersList.medicalCenters =  sender as! [MedicalCenter]
                fromSearchToMedicalCentersList.patient = patient
            }
        }
        
    }
    
    
}
