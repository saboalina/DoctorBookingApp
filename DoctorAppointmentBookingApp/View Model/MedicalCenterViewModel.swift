//
//  MedicalCenterViewModel.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 24.04.2022.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class MedicalCenterViewModel {
    
    static let shared = MedicalCenterViewModel()
    let db = Firestore.firestore()

    private init() {}
    
    func getAllMedicalCenters(collectionID: String, handler: @escaping ([MedicalCenter]) -> Void) {
        db.collection("medicalCenters")
                .addSnapshotListener { querySnapshot, err in
                    if let error = err {
                        print(error)
                        handler([])
                    } else {
                        handler(MedicalCenter.build(from: querySnapshot?.documents ?? []))
                    }
        }
    }
    
    func getMedicalCenterBy(name: String, handler: @escaping (Result<MedicalCenter, Error>) -> Void) {
        db.collection("medicalCenters").whereField("name", isEqualTo: name).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                handler(Result.failure(err))
            } else {
                if let data = querySnapshot?.documents.first?.data() {
                    handler(Result.success(MedicalCenter(document: data, id: querySnapshot?.documents.first?.documentID ?? "")))
                } else {
                    handler(Result.failure(MedicalCenterError.MedicalCenterNotFound))
                }
            }
        }
    }
    
}

