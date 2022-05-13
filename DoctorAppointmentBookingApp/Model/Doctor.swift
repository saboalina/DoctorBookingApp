
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
    
    var sun: String
    var mon: String
    var tue: String
    var wed: String
    var thu: String
    var fri: String
    var sat: String
    
    var imageURL: String?
    
    init(email: String, password: String, name: String, phoneNumber: String, worksAt: String, numberOfPatients: String, experience: String, consultancyFee: String, service: String, id: String, sun: String, mon: String, tue: String, wed: String, thu: String, fri: String, sat: String, imageURL: String){
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
        
        self.sun = sun
        self.mon = mon
        self.tue = tue
        self.wed = wed
        self.thu = thu
        self.fri = fri
        self.sat = sat
        
        self.imageURL = imageURL
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
        
        sun =           document["sun"] as? String ?? ""
        mon =           document["mon"] as? String ?? ""
        tue =           document["tue"] as? String ?? ""
        wed =           document["wed"] as? String ?? ""
        thu =           document["thu"] as? String ?? ""
        fri =           document["fri"] as? String ?? ""
        sat =           document["sat"] as? String ?? ""
        
        imageURL =           document["imageURL"] as? String ?? ""
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
                                id:         document.documentID,
                                sun:           document["sun"] as? String ?? "",
                                mon:           document["mon"] as? String ?? "",
                                tue:           document["tue"] as? String ?? "",
                                wed:           document["wed"] as? String ?? "",
                                thu:           document["thu"] as? String ?? "",
                                fri:           document["fri"] as? String ?? "",
                                sat:           document["sat"] as? String ?? "",
                                imageURL:           document["imageURL"] as? String ?? ""))
        }
        return users
    }
    
}
