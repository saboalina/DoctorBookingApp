//
//  Appointment.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 11.04.2022.
//

import Foundation
import FirebaseFirestore

public class Appointment: NSObject {
    
    var patientId: String
    var doctorId: String
    var date: String
    var time: String
    var type: String

    
    init(patientId: String, doctorId: String, date: String, time: String, type: String){
        self.patientId = patientId
        self.doctorId = doctorId
        self.date = date
        self.time = time
        self.type = type
    }
    
    func getPatientId() -> String {
        return patientId
    }
    
    func setPatientId(patientId: String) {
        self.patientId = patientId
    }
    
    func getDoctorId() -> String {
        return doctorId
    }
    
    func setDoctorId(doctorId: String) {
        self.doctorId = doctorId
    }
    
    func getDate() -> String {
        return date
    }
    
    func setDate(date: String) {
        self.date = date
    }
    
    func getTime() -> String {
        return time
    }
    
    func setTime(time: String) {
        self.time = time
    }
    
    func getType() -> String {
        return type
    }
    
    func setType(type: String) {
        self.type = type
    }

}

extension Appointment {
    static func build(from documents: [QueryDocumentSnapshot]) -> [Appointment] {
        var appointments = [Appointment]()
        for document in documents {
            appointments.append(Appointment(patientId:  document["patientId"] as? String ?? "",
                                            doctorId:   document["doctorId"] as? String ?? "",
                                            date:       document["date"] as? String ?? "",
                                            time:       document["time"] as? String ?? "",
                                            type:       document["type"] as? String ?? ""))
        }
        return appointments
    }
}
