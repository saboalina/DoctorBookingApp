
import XCTest

class DoctorAppointmentBookingAppTests: XCTestCase {
    
    func testgetAvailableDoctors() {
        
        let startDate = Date(timeIntervalSinceReferenceDate: 676278924.117903)
        let endDate = Date(timeIntervalSinceReferenceDate: 676454760.0)
        
        let doctor1 = Doctor(email: "doctor1", password: "doctor1", name: "doctor1", phoneNumber: "", worksAt: "", numberOfPatients: "", experience: "", consultancyFee: "", service: "", id: "", sun: "12:00-15:00", mon: "12:00-15:00", tue: "12:00-15:00", wed: "", thu: "", fri: "", sat: "", imageURL: "")
        let doctor2 = Doctor(email: "doctor2", password: "doctor2", name: "doctor2", phoneNumber: "", worksAt: "", numberOfPatients: "", experience: "", consultancyFee: "", service: "", id: "", sun: "", mon: "", tue: "12:00-15:00", wed: "12:00-15:00", thu: "12:00-15:00", fri: "12:00-15:00", sat: "12:00-15:00", imageURL: "")
        let doctor3 = Doctor(email: "doctor3", password: "doctor3", name: "doctor3", phoneNumber: "", worksAt: "", numberOfPatients: "", experience: "", consultancyFee: "", service: "", id: "", sun: "12:00-15:00", mon: "12:00-15:00", tue: "", wed: "12:00-15:00", thu: "", fri: "12:00-15:00", sat: "", imageURL: "")
        let doctor4 = Doctor(email: "doctor4", password: "doctor4", name: "doctor4", phoneNumber: "", worksAt: "", numberOfPatients: "", experience: "", consultancyFee: "", service: "", id: "", sun: "", mon: "", tue: "12:00-15:00", wed: "", thu: "12:00-15:00", fri: "", sat: "12:00-15:00", imageURL: "")
        let doctor5 = Doctor(email: "doctor5", password: "doctor5", name: "doctor5", phoneNumber: "", worksAt: "", numberOfPatients: "", experience: "", consultancyFee: "", service: "", id: "", sun: "", mon: "", tue: "", wed: "", thu: "", fri: "", sat: "", imageURL: "")
        var doctors = [Doctor]()
        doctors.append(doctor1)
        doctors.append(doctor2)
        doctors.append(doctor3)
        doctors.append(doctor4)
        doctors.append(doctor5)
        
        let filters = FiltersViewModel.shared
        filters.doctors = doctors
        
        let actual = filters.getAvailableDoctors(startDate: startDate, endDate: endDate)
        
        XCTAssertEqual(actual.count, 1)
        
    }

    func testgetAvailableMedicalCenters() {
        
        let startDate = Date(timeIntervalSinceReferenceDate: 676278924.117903)
        let endDate = Date(timeIntervalSinceReferenceDate: 676454760.0)
        
        let medicalCenter1 = MedicalCenter(name: "", address: "", services: "", sun: "12:00-15:00", mon: "12:00-15:00", tue: "12:00-15:00", wed: "", thu: "", fri: "", sat: "", latitude: "", longitude: "", id: "", imageURL: "")
        let medicalCenter2 = MedicalCenter(name: "", address: "", services: "", sun: "", mon: "", tue: "12:00-15:00", wed: "12:00-15:00", thu: "12:00-15:00", fri: "12:00-15:00", sat: "12:00-15:00", latitude: "", longitude: "", id: "", imageURL: "")
        let medicalCenter3 = MedicalCenter(name: "", address: "", services: "", sun: "12:00-15:00", mon: "12:00-15:00", tue: "", wed: "12:00-15:00", thu: "", fri: "12:00-15:00", sat: "", latitude: "", longitude: "", id: "", imageURL: "")
        let medicalCenter4 = MedicalCenter(name: "", address: "", services: "", sun: "", mon: "", tue: "12:00-15:00", wed: "", thu: "12:00-15:00", fri: "", sat: "12:00-15:00", latitude: "", longitude: "", id: "", imageURL: "")
        let medicalCenter5 = MedicalCenter(name: "", address: "", services: "", sun: "", mon: "", tue: "", wed: "", thu: "", fri: "", sat: "", latitude: "", longitude: "", id: "", imageURL: "")
        

        var medicalCenters = [MedicalCenter]()
        medicalCenters.append(medicalCenter1)
        medicalCenters.append(medicalCenter2)
        medicalCenters.append(medicalCenter3)
        medicalCenters.append(medicalCenter4)
        medicalCenters.append(medicalCenter5)
        
        let filters = FiltersViewModel.shared
        filters.medicalCenters = medicalCenters
        
        let actual = filters.getAvailableMedicalCenters(startDate: startDate, endDate: endDate)
        
        XCTAssertEqual(actual.count, 1)
        
    }
}
