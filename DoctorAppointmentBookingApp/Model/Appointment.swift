
import Foundation
import FirebaseFirestore

public class Appointment: NSObject {
    
    var patientId: String
    var doctorId: String
    var date: String
    var time: String
    var type: String
    var id: String

    
    init(patientId: String, doctorId: String, date: String, time: String, type: String, id: String){
        self.patientId = patientId
        self.doctorId = doctorId
        self.date = date
        self.time = time
        self.type = type
        self.id = id
    }
    
    init(document: [String:Any], id: String) {
        patientId =             document["patientId"] as? String ?? ""
        doctorId =              document["doctorId"] as? String ?? ""
        date =                  document["date"] as? String ?? ""
        time =                  document["time"] as? String ?? ""
        type =                  document["type"] as? String ?? ""
        self.id =               id
    }

}

extension Appointment {
    static func build(from documents: [QueryDocumentSnapshot]) -> [Appointment] {
        var appointments = [Appointment]()
        for document in documents {
            appointments.append(Appointment(patientId:  document["patientId"] as? String ?? "",
                                            doctorId:   document["doctorId"] as? String ?? "",
                                            date:       document["date"] as? String ?? "",
                                            time:       document["time"] as? String ?? "",
                                            type:       document["type"] as? String ?? "",
                                            id:         document.documentID))
        }
        return appointments
    }
}
