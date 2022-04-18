//
//  PatientViewModel.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 17.04.2022.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class PatientViewModel {
    
    let db = Firestore.firestore()
    
    func createUser(patient: Patient, completionBlock: @escaping (_ success: Bool) -> Void) {
            Auth.auth().createUser(withEmail: patient.email, password: patient.password) {(authResult, error) in
                    if let user = authResult?.user {
//                        print("-> \(user)")
                        //let db = Firestore.firestore()
                        self.db.collection("patients").addDocument(data: [
                            "email":patient.email,
                            "name":patient.name,
                            "phoneNumber":patient.phoneNumber,
                            "password":patient.password,
                            "history":patient.history,
                            "uid":authResult!.user.uid
                        ]) { (error) in
                            if error != nil {
                                print("error saving user data")
                            }
                        }
                        completionBlock(true)
                    } else {
                        completionBlock(false)
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

    
//    func getAllDoctors(collectionID: String, handler: @escaping ([Doctor]) -> Void) {
//        db.collection("doctors")
//                .addSnapshotListener { querySnapshot, err in
//                    if let error = err {
//                        print(error)
//                        handler([])
//                    } else {
//                        handler(Doctor.build(from: querySnapshot?.documents ?? []))
//                    }
//        }
//    }
    
//    func getDoctor(collectionID: String, email: String, password: String, handler: @escaping ([Doctor]) -> Void) {
//        db.collection("doctors").whereField("email", isEqualTo: email).whereField("password", isEqualTo: password)
//                .addSnapshotListener { querySnapshot, err in
//                    if let error = err {
//                        print(error)
//                        handler([])
//                    } else {
//                        handler(Doctor.build(from: querySnapshot?.documents ?? []))
//                    }
//        }
//    }
    
    func getPatientBy(email: String, handler: @escaping (Result<Patient, Error>) -> Void) {
        db.collection("patients").whereField("email", isEqualTo: email).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                handler(Result.failure(err))
            } else {
                if let data = querySnapshot?.documents.first?.data() {
                    handler(Result.success(Patient(document: data)))
                } else {
                    handler(Result.failure(PatientError.UserNotFound))
                }
            }
        }
    }
    
}

