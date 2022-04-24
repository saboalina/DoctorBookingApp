//
//  MedicalCentre.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 24.04.2022.
//

import Foundation
import FirebaseFirestore

public class MedicalCenter: NSObject {
    
    var name: String
    var address: String
    var services: String
    var doctors: String

    
    init(name: String, address: String, services: String, doctors: String){
        self.name = name
        self.address = address
        self.services = services
        self.doctors = doctors
    }

}

extension MedicalCenter {
    static func build(from documents: [QueryDocumentSnapshot]) -> [MedicalCenter] {
        var medicalCentres = [MedicalCenter]()
        for document in documents {
            medicalCentres.append(MedicalCenter(name:       document["name"] as? String ?? "",
                                                address:    document["address"] as? String ?? "",
                                                services:   document["services"] as? String ?? "",
                                                doctors:    document["doctors"] as? String ?? ""))
        }
        return medicalCentres
    }
}
