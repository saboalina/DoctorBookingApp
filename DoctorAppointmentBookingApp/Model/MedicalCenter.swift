

import Foundation
import FirebaseFirestore

public class MedicalCenter: NSObject {
    
    var name: String
    var address: String
    var services: String

    var sun: String
    var mon: String
    var tue: String
    var wed: String
    var thu: String
    var fri: String
    var sat: String
    
    var latitude: String
    var longitude: String
    
    var id: String
    var imageURL: String?
    
    init(name: String, address: String, services: String, sun: String, mon: String, tue: String, wed: String, thu: String, fri: String, sat: String, latitude: String, longitude: String, id: String, imageURL: String){
        self.name = name
        self.address = address
        self.services = services
        
        self.sun = sun
        self.mon = mon
        self.tue = tue
        self.wed = wed
        self.thu = thu
        self.fri = fri
        self.sat = sat
        
        self.id = id
        
        self.latitude = latitude
        self.longitude = longitude
        
        self.imageURL = imageURL
    }
    
    init(document: [String:Any], id: String) {
        name =          document["name"] as? String ?? ""
        address =       document["address"] as? String ?? ""
        services =      document["services"] as? String ?? ""
        sun =           document["sun"] as? String ?? ""
        mon =           document["mon"] as? String ?? ""
        tue =           document["tue"] as? String ?? ""
        wed =           document["wed"] as? String ?? ""
        thu =           document["thu"] as? String ?? ""
        fri =           document["fri"] as? String ?? ""
        sat =           document["sat"] as? String ?? ""
        latitude =      document["latitude"] as? String ?? ""
        longitude =     document["longitude"] as? String ?? ""
        self.id =               id
        
        imageURL =           document["imageURL"] as? String ?? ""
    }

}

extension MedicalCenter {
    static func build(from documents: [QueryDocumentSnapshot]) -> [MedicalCenter] {
        var medicalCentres = [MedicalCenter]()
        for document in documents {
            medicalCentres.append(MedicalCenter(name:       document["name"] as? String ?? "",
                                                address:    document["address"] as? String ?? "",
                                                services:   document["services"] as? String ?? "",
                                                sun:           document["Sun"] as? String ?? "",
                                                mon:           document["Mon"] as? String ?? "",
                                                tue:           document["Tue"] as? String ?? "",
                                                wed:           document["Wed"] as? String ?? "",
                                                thu:           document["Thu"] as? String ?? "",
                                                fri:           document["fri"] as? String ?? "",
                                                sat:           document["Sat"] as? String ?? "",
                                                latitude:           document["latitude"] as? String ?? "",
                                                longitude:           document["longitude"] as? String ?? "",
                                                id:         document.documentID,
                                                imageURL:           document["imageURL"] as? String ?? ""
))
        }
        return medicalCentres
    }
}
