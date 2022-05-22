
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AppointmentViewModel {
    
    static let shared = AppointmentViewModel()
    let db = Firestore.firestore()
    
    private init() {}
 
    func addAppointment(appointment: Appointment, completionBlock: @escaping (_ success: Bool) -> Void) {
        
        self.db.collection("appointments").addDocument(data: [
            "patientId":appointment.patientId,
            "doctorId":appointment.doctorId,
            "date":appointment.date,
            "time":appointment.time,
            "type":appointment.type
        ]) { error in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
        }

    func getAllAppointmentsForADoctor(collectionID: String, doctorEmail: String, handler: @escaping ([Appointment]) -> Void) {
        db.collection("appointments").whereField("doctorId", isEqualTo: doctorEmail)
                .addSnapshotListener { querySnapshot, err in
                    if let error = err {
                        handler([])
                    } else {
                        handler(Appointment.build(from: querySnapshot?.documents ?? []))
                    }
        }
    }
    
    func getAllAppointmentsForAPatient(collectionID: String, patientEmail: String, handler: @escaping ([Appointment]) -> Void) {
        db.collection("appointments").whereField("patientId", isEqualTo: patientEmail)
                .addSnapshotListener { querySnapshot, err in
                    if let error = err {
                        handler([])
                    } else {
                        handler(Appointment.build(from: querySnapshot?.documents ?? []))
                    }
                }
        }
      
    func deleteAppointment(appointment: Appointment, completionBlock: @escaping (_ success: Bool) -> Void) {
        
        db.collection("appointments").document(appointment.id).delete() { error in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
}
