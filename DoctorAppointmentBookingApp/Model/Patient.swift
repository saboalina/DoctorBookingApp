//
//  Patient.swift
//  DoctorAppointmentBookingApp
//
//  Created by Alina Sabo Brandus on 17.04.2022.
//

import Foundation
import FirebaseFirestore

public class Patient: NSObject {
    
    var email: String
    var password: String
    var name: String
    var phoneNumber: String
    var history: String

    
    init(email: String, password: String, name: String, phoneNumber: String, history: String){
        self.email = email
        self.password = password
        self.name = name
        self.phoneNumber = phoneNumber
        self.history = history

    }
    
    init(document: [String:Any]) {
        email =             document["email"] as? String ?? ""
        password =          document["password"] as? String ?? ""
        name =              document["name"] as? String ?? ""
        phoneNumber =       document["phoneNumber"] as? String ?? ""
        history =           document["history"] as? String ?? ""

    }
    

}

extension Patient {
    static func build(from documents: [QueryDocumentSnapshot]) -> [Patient] {
        var users = [Patient]()
        for document in documents {
            users.append(Patient(email:              document["email"] as? String ?? "",
                                password:           document["password"] as? String ?? "",
                                name:               document["name"] as? String ?? "",
                                phoneNumber:        document["phoneNumber"] as? String ?? "",
                                history:            document["history"] as? String ?? ""))
        }
        return users
    }
    
}

