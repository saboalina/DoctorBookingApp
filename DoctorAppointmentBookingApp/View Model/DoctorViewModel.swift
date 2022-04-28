//
//  DoctorViewModel.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 03.04.2022.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class DoctorViewModel {
    
    let db = Firestore.firestore()
    
    func createUser(doctor: Doctor, completionBlock: @escaping (_ success: AuthErrorCode?) -> Void) {
            Auth.auth().createUser(withEmail: doctor.email, password: doctor.password) {(authResult, error) in
               
                if let err = error {
                    let errCode = AuthErrorCode(rawValue: err._code)
                    completionBlock(errCode)
                } else {
                    self.db.collection("doctors").addDocument(data: [
                                        "email":doctor.email,
                                        "name":doctor.name,
                                        "phoneNumber":doctor.phoneNumber,
                                        "password":doctor.password,
                                        "consultancyFee":doctor.consultancyFee,
                                        "service":doctor.service,
                                        "experience":doctor.experience,
                                        "numberOfPatients":doctor.numberOfPatients,
                                        "worksAt":doctor.worksAt
                    ]) { (error) in
                        if error == nil {
                            completionBlock(nil)
                        } else {
                            completionBlock(AuthErrorCode.networkError)
                        }
                    }
                }
            }
        }
    
    
    func login(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
            Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
                if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                    completionBlock(false)
                } else {
                    completionBlock(true)
                }
            }
        }

    
    func getAllDoctors(collectionID: String, handler: @escaping ([Doctor]) -> Void) {
        db.collection("doctors")
                .addSnapshotListener { querySnapshot, err in
                    if let error = err {
                        print(error)
                        handler([])
                    } else {
                        handler(Doctor.build(from: querySnapshot?.documents ?? []))
                    }
        }
    }
    
    func getDoctorBy(email: String, handler: @escaping (Result<Doctor, Error>) -> Void) {
        db.collection("doctors").whereField("email", isEqualTo: email).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                handler(Result.failure(err))
            } else {
                if let data = querySnapshot?.documents.first?.data() {
                    handler(Result.success(Doctor(document: data, id: querySnapshot?.documents.first?.documentID ?? "")))
                } else {
                    handler(Result.failure(DoctorError.UserNotFound))
                }
            }
        }
    }
    
    func getDoctorsAvailableIn(day: String, handler: @escaping ([Doctor]) -> Void){
        let dayOfTheWeek = "\(day)"
        db.collection("doctors").whereField(dayOfTheWeek, isNotEqualTo: "")
                .addSnapshotListener { querySnapshot, err in
                    if let error = err {
                        print(error)
                        handler([])
                    } else {
                        handler(Doctor.build(from: querySnapshot?.documents ?? []))
                    }
        }
    }
    
    func updateDoctor(doctorId: String, name: String, phoneNumber: String, service: String, worksAt: String, experience: String, consultancyFee: String, handler: @escaping (Bool) -> Void ) {
        db.collection("doctors").document(doctorId).setData([
            "name":         name,
            "phoneNumber":  phoneNumber,
            "service":      service,
            "worksAt":  worksAt,
            "experience":      experience,
            "consultancyFee":      consultancyFee,
        ], merge: true) { err in
            if let _ = err {
                handler(false)
            } else {
                handler(true)
            }
        }
    }
    
}
