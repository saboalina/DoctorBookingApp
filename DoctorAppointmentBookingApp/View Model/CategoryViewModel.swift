
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class CategoryViewModel {
    
    static let shared = CategoryViewModel()
    let db = Firestore.firestore()
    
    private init() {}

    func getAllCategories(collectionID: String, handler: @escaping ([Category]) -> Void) {
        db.collection("categories")
                .addSnapshotListener { querySnapshot, err in
                    if let error = err {
                        print(error)
                        handler([])
                    } else {
                        handler(Category.build(from: querySnapshot?.documents ?? []))
                    }
        }
    }
    
}
