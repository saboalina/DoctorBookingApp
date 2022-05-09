
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class PatientViewModel {
    
    static let shared = PatientViewModel()
    let db = Firestore.firestore()
    
    private init() {}
    
    func createUser(patient: Patient, completionBlock: @escaping (_ success: Bool) -> Void) {
            Auth.auth().createUser(withEmail: patient.email, password: patient.password) {(authResult, error) in
                    if let user = authResult?.user {
                        self.db.collection("patients").addDocument(data: [
                            "email":patient.email,
                            "name":patient.name,
                            "phoneNumber":patient.phoneNumber,
                            "password":patient.password,
                            "history":patient.history
                        ]) { (error) in
                            if error != nil {
                                print("error saving user data")
                            }
                        }
                        completionBlock(true)
                    } else {
                        completionBlock(false)
                    }
                }
        }
    
    
    func login(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
            Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
                if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                    completionBlock(false)
                } else {
                    completionBlock(true)
                }
            }
        }

    func getPatientBy(email: String, handler: @escaping (Result<Patient, Error>) -> Void) {
        db.collection("patients").whereField("email", isEqualTo: email).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                handler(Result.failure(err))
            } else {
                if let data = querySnapshot?.documents.first?.data() {
                    handler(Result.success(Patient(document: data, id: querySnapshot?.documents.first?.documentID ?? "")))
                } else {
                    handler(Result.failure(PatientError.UserNotFound))
                }
            }
        }
    }
    
    
    func updatePatient(patientId: String, name: String, phoneNumber: String, history: String, handler: @escaping (Bool) -> Void) {
        db.collection("patients").document(patientId).setData([
            "name":         name,
            "phoneNumber":  phoneNumber,
            "history":      history
        ], merge: true) { err in
            if let _ = err {
                handler(false)
            } else {
                handler(true)
            }
        }
    }
    
}

