//
//  AppointmentViewModel.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 11.04.2022.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AppointmentViewModel {
    
//    var allAppointments = [Appointment]()
    let db = Firestore.firestore()
 
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
//        var patientId: String
//        var doctorId: String
//        var date: String
//        var time: String
//        var type: String
//        var id: String
//
//
//            Auth.auth().createUser(withEmail: patient.email, password: patient.password) {(authResult, error) in
//                    if let user = authResult?.user {
////                        print("-> \(user)")
//                        //let db = Firestore.firestore()
//                        self.db.collection("patients").addDocument(data: [
//                            "email":patient.email,
//                            "name":patient.name,
//                            "phoneNumber":patient.phoneNumber,
//                            "password":patient.password,
//                            "history":patient.history
//                        ]) { (error) in
//                            if error != nil {
//                                print("error saving user data")
//                            }
//                        }
//                        completionBlock(true)
//                    } else {
//                        completionBlock(false)
//                    }
//                }
        }

    func getAllAppointmentsForADoctor(collectionID: String, doctorEmail: String, handler: @escaping ([Appointment]) -> Void) {
        db.collection("appointments").whereField("doctorId", isEqualTo: doctorEmail)
                .addSnapshotListener { querySnapshot, err in
                    if let error = err {
                        print(error)
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
                        print(error)
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
