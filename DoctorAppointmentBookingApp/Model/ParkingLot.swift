

import Foundation
import FirebaseFirestore

public class ParkingLot: NSObject {
    
    var name: String

    var latitude: String
    var longitude: String
    
    init(name: String, latitude: String, longitude: String){
        self.name = name

        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    init(document: [String:Any], id: String) {
        name =          document["name"] as? String ?? ""
        latitude =      document["latitude"] as? String ?? ""
        longitude =     document["longitude"] as? String ?? ""
    }

}

extension ParkingLot {
    static func build(from documents: [QueryDocumentSnapshot]) -> [ParkingLot] {
        var parkingLots = [ParkingLot]()
        for document in documents {
            parkingLots.append(ParkingLot(name:       document["name"] as? String ?? "",
                                            latitude:           document["latitude"] as? String ?? "",
                                            longitude:           document["longitude"] as? String ?? ""
))
        }
        return parkingLots
    }
}
