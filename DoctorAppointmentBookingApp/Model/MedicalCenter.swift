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

    var sun: String
    var mon: String
    var tue: String
    var wed: String
    var thu: String
    var fri: String
    var sat: String
    
    var latitude: String
    var longitude: String
    
    init(name: String, address: String, services: String, doctors: String, sun: String, mon: String, tue: String, wed: String, thu: String, fri: String, sat: String, latitude: String, longitude: String){
        self.name = name
        self.address = address
        self.services = services
        self.doctors = doctors
        
        self.sun = sun
        self.mon = mon
        self.tue = tue
        self.wed = wed
        self.thu = thu
        self.fri = fri
        self.sat = sat
        
        self.latitude = latitude
        self.longitude = longitude
    }

}

extension MedicalCenter {
    static func build(from documents: [QueryDocumentSnapshot]) -> [MedicalCenter] {
        var medicalCentres = [MedicalCenter]()
        for document in documents {
            medicalCentres.append(MedicalCenter(name:       document["name"] as? String ?? "",
                                                address:    document["address"] as? String ?? "",
                                                services:   document["services"] as? String ?? "",
                                                doctors:    document["doctors"] as? String ?? "",
                                                sun:           document["Sun"] as? String ?? "",
                                                mon:           document["Mon"] as? String ?? "",
                                                tue:           document["Tue"] as? String ?? "",
                                                wed:           document["Wed"] as? String ?? "",
                                                thu:           document["Thu"] as? String ?? "",
                                                fri:           document["Fri"] as? String ?? "",
                                                sat:           document["Sat"] as? String ?? "",
                                                latitude:           document["latitude"] as? String ?? "",
                                                longitude:           document["longitude"] as? String ?? ""))
        }
        return medicalCentres
    }
}
