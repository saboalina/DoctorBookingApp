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
    
//    func createUser(doctor: Doctor, completionBlock: @escaping (_ success: Bool) -> Void) {
//            Auth.auth().createUser(withEmail: doctor.email, password: doctor.password) {(authResult, error) in
//                    if let user = authResult?.user {
//                        print("-> \(user)")
//                        //let db = Firestore.firestore()
//                        self.db.collection("doctors").addDocument(data: [
//                            "username":doctor.username,
//                            "name":doctor.name,
//                            "email":doctor.email,
//                            "phoneNumber":doctor.phoneNumber,
//                            "password":doctor.password,
//                            "consultancyFee":doctor.consultancyFee,
//                            "department":doctor.department,
//                            "experience":doctor.experience,
//                            "numberOfPatients":doctor.numberOfPatients,
//                            "worksAt":doctor.worksAt,
//                            "uid":authResult!.user.uid
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
//        }
//
//
//    func login(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
//            Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
//                if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
//                    completionBlock(false)
//                } else {
//                    completionBlock(true)
//                }
//            }
//        }
//
//
//    func getAllDoctors() -> [Doctor] {
//        //let db = Firestore.firestore()
//
//        db.collection("doctors").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    //print("\(document.documentID) => \(document.data())")
//                    //allDoctors.append(document.data())
//                    //print("==> \(document.data().keys) - \(document.data().values)")
////                    if let dictionary = document.data() as? [String:AnyObject] {
////                        let doctor = Doctor(username: "", password: "", name: "", email: document.value(forKey: "email") as! String, phoneNumber: "", worksAt: "", numberOfPatients: "", experience: "", consultancyFee: "", department: "")
////                        //doctor.setValueForKeysWithDictionaty(dictionary)
////                        print("=> \(doctor)")
////                    }
//
//                    let username: String            = document.data()["username"] as? String ?? ""
//                    let password: String            = document.data()["password"] as? String ?? ""
//                    let name: String                = document.data()["name"] as? String ?? ""
//                    let email: String               = document.data()["email"] as? String ?? ""
//                    let phoneNumber: String         = document.data()["phoneNumber"] as? String ?? ""
//                    let worksAt: String             = document.data()["worksAt"] as? String ?? ""
//                    let numberOfPatients: String    = document.data()["numberOfPatients"] as? String ?? ""
//                    let experience: String          = document.data()["experience"] as? String ?? ""
//                    let consultancyFee: String      = document.data()["consultancyFee"] as? String ?? ""
//                    let department: String          = document.data()["department"] as? String ?? ""
//
//                    let doctor = Doctor(username: username, password: password, name: name, email: email, phoneNumber: phoneNumber, worksAt: worksAt, numberOfPatients: numberOfPatients, experience: experience, consultancyFee: consultancyFee, department: department)
//
//                    self.allDoctors.append(doctor)
//
//                    //print("==> \(self.allDoctors)")
//                }
//            }
//        }
//        return self.allDoctors
//
//    }

    
//    func getAllAppointments(collectionID: String, handler: @escaping ([Appointment]) -> Void) {
//        db.collection("appointments")
//                .addSnapshotListener { querySnapshot, err in
//                    if let error = err {
//                        print(error)
//                        handler([])
//                    } else {
//                        handler(Appointment.build(from: querySnapshot?.documents ?? []))
//                    }
//                }
//        }
    
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
    
}
