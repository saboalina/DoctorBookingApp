
import Foundation
import FirebaseFirestore

public class Category: NSObject {

    var name: String
    var id: String
    var imageURL: String?
    
    init(name: String, id: String, imageURL: String){

        self.name = name
        self.id = id
        self.imageURL = imageURL
    }
    
    init(document: [String:Any], id: String) {
        
        name =              document["name"] as? String ?? ""
        self.id =               id
        imageURL =           document["imageURL"] as? String ?? ""
    }

}

extension Category {
    static func build(from documents: [QueryDocumentSnapshot]) -> [Category] {
        var users = [Category]()
        for document in documents {
            users.append(Category(name:               document["name"] as? String ?? "",
                                id:         document.documentID,
                                imageURL:           document["imageURL"] as? String ?? ""))
        }
        return users
    }
    
}
