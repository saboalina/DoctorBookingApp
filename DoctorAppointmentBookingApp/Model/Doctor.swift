//
//  Doctor.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 03.04.2022.
//

import Foundation
import FirebaseFirestore

public class Doctor: NSObject {
    
    var email: String
    var password: String
    var name: String
    var phoneNumber: String
    var worksAt: String
    var numberOfPatients: String
    var experience: String
    var consultancyFee: String
    var service: String
    var id: String
    
    init(email: String, password: String, name: String, phoneNumber: String, worksAt: String, numberOfPatients: String, experience: String, consultancyFee: String, service: String, id: String){
        self.email = email
        self.password = password
        self.name = name
        self.phoneNumber = phoneNumber
        self.worksAt = worksAt
        self.numberOfPatients = numberOfPatients
        self.experience = experience
        self.consultancyFee = consultancyFee
        self.service = service
        self.id = id
    }
    
    init(document: [String:Any], id: String) {
        email =             document["email"] as? String ?? ""
        password =          document["password"] as? String ?? ""
        name =              document["name"] as? String ?? ""
        phoneNumber =       document["phoneNumber"] as? String ?? ""
        worksAt =           document["worksAt"] as? String ?? ""
        numberOfPatients =  document["numberOfPatients"] as? String ?? ""
        experience =        document["experience"] as? String ?? ""
        consultancyFee =    document["consultancyFee"] as? String ?? ""
        service =           document["service"] as? String ?? ""
        self.id =               id
    }

}

extension Doctor {
    static func build(from documents: [QueryDocumentSnapshot]) -> [Doctor] {
        var users = [Doctor]()
        for document in documents {
            users.append(Doctor(email:              document["email"] as? String ?? "",
                                password:           document["password"] as? String ?? "",
                                name:               document["name"] as? String ?? "",
                                phoneNumber:        document["phoneNumber"] as? String ?? "",
                                worksAt:            document["worksAt"] as? String ?? "",
                                numberOfPatients:   document["numberOfPatients"] as? String ?? "",
                                experience:         document["experience"] as? String ?? "",
                                consultancyFee:     document["consultancyFee"] as? String ?? "",
                                service:            document["service"] as? String ?? "",
                                id:         document.documentID))
        }
        return users
    }
    
}
