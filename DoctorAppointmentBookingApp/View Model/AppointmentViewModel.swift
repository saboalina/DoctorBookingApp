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
    
    var allAppointments = [Appointment]()
    let db = Firestore.firestore()
 

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
