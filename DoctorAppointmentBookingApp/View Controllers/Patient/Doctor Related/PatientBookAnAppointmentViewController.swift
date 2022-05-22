
import UIKit

class PatientBookAnAppointmentViewController: UIViewController {
    
    
    @IBOutlet weak var appointmentDatePicker: UIDatePicker!
    
    @IBOutlet weak var slotsCollectionView: UICollectionView!
    
    var filterViewModel = FiltersViewModel.shared
    var appointmentViewModel = AppointmentViewModel.shared
    
    var patient: Patient!
    var doctor: Doctor!
    var appointmentDate: String = ""
    var appointmentTime: String = ""
    var slots: [String] = []
    var selectedSlot: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentDatePicker.datePickerMode = UIDatePicker.Mode.date
        getSlots(picker: appointmentDatePicker)
        appointmentDatePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        registerCells()
        
        slotsCollectionView.delegate = self
        slotsCollectionView.dataSource = self
        
    }
    
    func getSlots(picker: UIDatePicker) {
        let dateInfoString = "\(picker.date)"
        let dateInfo = dateInfoString.components(separatedBy: " ")
        appointmentDate = dateInfo[0]
        
        var program = ""
        
        let day = filterViewModel.getDayOfTheWeekByDate(date: picker.date)
        if day == "Mon" {
            program = doctor.mon
            slots = getSlotsFromString(stringDate: program)
        }
        if day == "Tue" {
            program = doctor.tue
            slots = getSlotsFromString(stringDate: program)
        }
        if day == "Wed" {
            program = doctor.wed
            slots = getSlotsFromString(stringDate: program)
        }
        if day == "Thu" {
            program = doctor.thu
            slots = getSlotsFromString(stringDate: program)
        }
        if day == "Fri" {
            program = doctor.fri
            slots = getSlotsFromString(stringDate: program)
        }
        if day == "Sat" {
            program = doctor.sat
            slots = getSlotsFromString(stringDate: program)
        }
        if day == "Sun" {
            program = doctor.sun
            slots = getSlotsFromString(stringDate: program)
        }
        slotsCollectionView.reloadData()
    }
    
    func getSlotsFromString(stringDate: String) -> [String]{
        
        let timesOfTheString = stringDate.components(separatedBy: "-")
        let startTime = timesOfTheString[0].components(separatedBy: ":")
        let endTime = timesOfTheString[1].components(separatedBy: ":")
        
        var startHour = Int(startTime[0])!
        var startMinute = Int(startTime[1])!
        
        let endHour = Int(endTime[0])!
        let endMinute = Int(endTime[1])!
        
        var numberOfMinutes = 0
        
        if startMinute != 0 {
            numberOfMinutes += 60 - startMinute
            startHour += 1
        }
        
        if endMinute != 0 {
            numberOfMinutes += endMinute
        }
         
        numberOfMinutes += (endHour - startHour) * 60
        var numberOfSlots = numberOfMinutes / 15
        var slotValue = ""
        var slotsOfTheDay: [String] = []
        
        startHour -= 1
        
        while numberOfSlots > 0 {
            if startMinute + 15 == 60 {
                slotValue = "\(startHour):\(startMinute)-\(startHour+1):00"
                startMinute = 0
                startHour += 1
            } else if startMinute == 0{
                slotValue = "\(startHour):\(startMinute)0-\(startHour):\(startMinute+15)"
                startMinute += 15
            } else {
                slotValue = "\(startHour):\(startMinute)-\(startHour):\(startMinute+15)"
                startMinute += 15
            }
            slotsOfTheDay.append(slotValue)
            numberOfSlots = numberOfSlots - 1
        }

        return slotsOfTheDay
    }
        
    @objc func datePickerChanged(picker: UIDatePicker) {
        
        getSlots(picker: picker)
    }
    
    @IBAction func confirmAppointmentButtonTapped(_ sender: Any) {
        let appointment = Appointment(patientId: patient.email, doctorId: doctor.email, date: appointmentDate, time: appointmentTime, type: doctor.service, id: "")
        if appointmentTime != "" {
            appointmentViewModel.addAppointment(appointment: appointment) { success in
                if (success) {
                    let timeString = self.appointmentTime.components(separatedBy: "-")
                    let time = timeString[0]
                    let message = "You have created an appointment on \(self.appointmentDate) from \(time) with Dr. \(self.doctor.name) "
                    let alert = UIAlertController(title: "Your appointment is created", message: message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "There was an error.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "You need to select a slot", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func registerCells() {
        slotsCollectionView.register(UINib(nibName: SlotViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SlotViewCell.identifier)
        
    }

}

extension PatientBookAnAppointmentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlotViewCell.identifier, for: indexPath) as! SlotViewCell
        cell.setup(slot: slots[indexPath.row])
        cell.backgroundColor = selectedSlot == indexPath.row ? UIColor.green : UIColor.yellow

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSlot = indexPath.row
        slotsCollectionView.reloadData()
        appointmentTime = slots[indexPath.row]
    }
    
    
}
