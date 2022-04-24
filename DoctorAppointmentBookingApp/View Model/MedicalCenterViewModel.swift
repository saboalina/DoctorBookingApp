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
    
    let db = Firestore.firestore()

    
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
    
}

