
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class DoctorViewModel {
    
    static let shared = DoctorViewModel()
    let db = Firestore.firestore()
    
    private init() {}
    
    func createUser(doctor: Doctor, completionBlock: @escaping (_ success: AuthErrorCode?) -> Void) {
            Auth.auth().createUser(withEmail: doctor.email, password: doctor.password) {(authResult, error) in
               
                if let err = error {
                    let errCode = AuthErrorCode(rawValue: err._code)
                    completionBlock(errCode)
                } else {
                    self.db.collection("doctors").addDocument(data: [
                                        "email":doctor.email,
                                        "name":doctor.name,
                                        "phoneNumber":doctor.phoneNumber,
                                        "password":doctor.password,
                                        "consultancyFee":doctor.consultancyFee,
                                        "service":doctor.service,
                                        "experience":doctor.experience,
                                        "numberOfPatients":doctor.numberOfPatients,
                                        "worksAt":doctor.worksAt,
                                        "imageURL": doctor.imageURL
                    ]) { (error) in
                        if error == nil {
                            completionBlock(nil)
                        } else {
                            completionBlock(AuthErrorCode.networkError)
                        }
                    }
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

    
    func getAllDoctors(collectionID: String, handler: @escaping ([Doctor]) -> Void) {
        db.collection("doctors")
                .addSnapshotListener { querySnapshot, err in
                    if let error = err {
                        print(error)
                        handler([])
                    } else {
                        handler(Doctor.build(from: querySnapshot?.documents ?? []))
                    }
        }
    }
    
    func getDoctorBy(email: String, handler: @escaping (Result<Doctor, Error>) -> Void) {
        db.collection("doctors").whereField("email", isEqualTo: email).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                handler(Result.failure(err))
            } else {
                if let data = querySnapshot?.documents.first?.data() {
                    handler(Result.success(Doctor(document: data, id: querySnapshot?.documents.first?.documentID ?? "")))
                } else {
                    handler(Result.failure(DoctorError.UserNotFound))
                }
            }
        }
    }
        
    func updateDoctor(doctorId: String, name: String, phoneNumber: String, service: String, worksAt: String, consultancyFee: String, mon: String, tue: String, wed: String, thu: String, fri: String, sat: String, sun: String, handler: @escaping (Bool) -> Void ) {
        db.collection("doctors").document(doctorId).setData([
            "name":         name,
            "phoneNumber":  phoneNumber,
            "service":      service,
            "worksAt":  worksAt,
            "consultancyFee":      consultancyFee,
            "mon":      mon,
            "tue":      tue,
            "wed":      wed,
            "thu":      thu,
            "fri":      fri,
            "sat":      sat,
            "sun":      sun,
        ], merge: true) { err in
            if let _ = err {
                handler(false)
            } else {
                handler(true)
            }
        }
    }
    
    
    func resetPassword(email: String, onSuccess: @escaping() -> Void, onError:  @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) {
            (error) in
            if error == nil {
                onSuccess()
            } else {
                onError(error!.localizedDescription)
            }
        }
    }
    
}
