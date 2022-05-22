
import UIKit
import Firebase
import UserNotifications

class PatientHomeViewController: UIViewController {
    
    
    @IBOutlet weak var doctorCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var medicalCenterCollectionView: UICollectionView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    var doctorViewModel = DoctorViewModel.shared
    var medicalCenterViewModel = MedicalCenterViewModel.shared
    var appointmentViewModel = AppointmentViewModel.shared
    var filterViewModel = FiltersViewModel.shared
    var categoryViewModel = CategoryViewModel.shared

    
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
                self.checkDates()
            }
        }
    }
    
    private var allCategories = [Category]() {
        didSet {
            DispatchQueue.main.async {
                self.categories = self.allCategories
            }
        }
    }

    var categories = [Category]() {
        didSet {
            DispatchQueue.main.async {
                self.categoriesCollectionView.reloadData()
            }
        }
    }
    
//    let categories = ["Dermatology", "Oral health", "Pulmonology", "Orthopedics", "Plastic surgery", "Gynecology", "Cardiology", "Ophthalmology", "Neurology", "Urology", "Hepatology"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        registerCell()
        
        searchButton.layer.cornerRadius = 20
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        searchButton.layer.shadowOpacity = 0.3
        searchButton.layer.shadowRadius = 4.0
        searchButton.tintColor = UIColor.white
        view.backgroundColor = Colors.brown
                
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
        
        categoryViewModel.getAllCategories(collectionID: "categories") { categories in
                self.categories = categories
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
        content.userInfo = ["example": "information"]
        
        let date = convertDate(date: Date() + 5)
                
        let trigger = UNCalendarNotificationTrigger(dateMatching: date as DateComponents, repeats: false)
        
        let uniqueID = UUID().uuidString
        let request = UNNotificationRequest(identifier: uniqueID, content: content, trigger: trigger)
        center.add(request) 
    }
    
    func convertDate(date: Date) -> NSDateComponents {

        let calendar = Calendar.current

        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)

        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let sec = calendar.component(.second, from: date)

        let newDate = NSDateComponents()

        newDate.timeZone = TimeZone.current

        newDate.hour = hour
        newDate.minute = minutes
        newDate.second = sec

        newDate.day = day
        newDate.month = month
        newDate.year = year

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
            if let profilePictureURL = doctors[indexPath.row].imageURL {
                let url = NSURL(string: profilePictureURL)
                URLSession.shared.dataTask(with: url! as URL, completionHandler: {
                    (data, response, error) in
                    
                    if error != nil {
                        return
                    }
                    DispatchQueue.main.async {
                        cell.doctorImageView.image  = UIImage(data: data!)
                        cell.doctorImageView.contentMode = .scaleAspectFill
                    }
                }).resume()
            }
            return cell
        }
        if collectionView == self.categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesViewCell.identifier, for: indexPath) as! CategoriesViewCell
            cell.setup(category: categories[indexPath.row])
            
            if let categoryURL = categories[indexPath.row].imageURL {
                let url = NSURL(string: categoryURL)
                URLSession.shared.dataTask(with: url! as URL, completionHandler: {
                    (data, response, error) in
                    
                    if error != nil {
                        return
                    }
                    DispatchQueue.main.async {
                        cell.categoryImage.image  = UIImage(data: data!)
                        cell.categoryImage.contentMode = .scaleAspectFill
                    }
                }).resume()
            }
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicalCenterHorizontalViewCell.identifier, for: indexPath) as! MedicalCenterHorizontalViewCell
        cell.setup(medicalCenter: medicalCenters[indexPath.row])
        if let profilePictureURL = medicalCenters[indexPath.row].imageURL {
            let url = NSURL(string: profilePictureURL)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    return
                }
                DispatchQueue.main.async {
                    cell.medicalImageView.image  = UIImage(data: data!)
                    //cell.doctorImageView.contentMode = .scaleAspectFill
                }
            }).resume()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.doctorCollectionView {
            let doctor = doctors[indexPath.row]
            performSegue(withIdentifier: "showDoctorDetails", sender: doctor)

        }
        
        if collectionView == self.categoriesCollectionView {
            let service = categories[indexPath.row].name
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
                doctorDetailsViewConntroller.doctor =  sender as? Doctor
                doctorDetailsViewConntroller.patient = patient
            }
        }
        
        if segue.identifier == "showMedicalCenterDetails" {
            if let medicalCenterDetailsViewConntroller = segue.destination as? PatientMedicalCenterDetailsViewController {
                medicalCenterDetailsViewConntroller.medicalCenter =  sender as? MedicalCenter
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
