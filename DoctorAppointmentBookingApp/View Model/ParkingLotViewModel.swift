
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ParkingLotViewModel {
    
    static let shared = ParkingLotViewModel()
    let db = Firestore.firestore()

    private init() {}
    
    func getAllParkingLots(collectionID: String, handler: @escaping ([ParkingLot]) -> Void) {
        db.collection("parkingLots")
                .addSnapshotListener { querySnapshot, err in
                    if let error = err {
                        handler([])
                    } else {
                        handler(ParkingLot.build(from: querySnapshot?.documents ?? []))
                    }
        }
    }
}

