//
//  UserManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class UserManager {
    
    static let shared = UserManager()
    
    private init() {}
    
    private let usersCollection = Firestore.firestore().collection("users")
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    func createNewUser(user: DBUser, completion: @escaping ((Error?) -> Void)) {
        do {
            try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
            completion(nil)
        } catch {
            completion(SMError.decodingError)
        }
    }
    
//    func createNewUser(authModel: AuthDataResultModel, completion: @escaping ((Error?) -> Void)) {
//        guard let user = Auth.auth().currentUser, let email = authModel.email else { return }
//        var userData: [String: Any] = [
//            "user_id": authModel.uid,
//            "date_created": Timestamp(),
//            "email": email,
//            "is_verified": user.isEmailVerified
//        ]
//        if let photoUrl = authModel.photoUrl {
//            userData["photoUrl"] = photoUrl
//        }
//        userDocument(userId: authModel.uid).setData(userData, merge: false, completion: completion)
//    }
    
    func getUser(userId: String, completion: @escaping (Result<DBUser, Error>) -> Void) {
        userDocument(userId: userId).getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            guard let user = DBUser(dictionary: data) else {
                completion(.failure(SMError.decodingError))
                return
            }
            completion(.success(user))
        }
    }
//    
//    func getUser(userId: String, completion: @escaping (Result<DBUser, Error>) -> Void) {
//        userDocument(userId: userId).getDocument { snapshot, error in
//            guard let data = snapshot?.data(), error == nil else {
//                completion(.failure(error ?? URLError(.badServerResponse)))
//                return
//            }
//            let email = data["email"] as? String ?? ""
//            let photoUrl = data["photo_url"] as? String ?? ""
//            let isVerified = data["is_verified"] as? Bool ?? false
//            let dateCreated = data["date_created"] as? Date
//            completion(.success( DBUser(userId: userId, email: email, isVerified: isVerified, photoUrl: photoUrl, dateCreated: dateCreated ?? Date())))
//        }
//    }
    
    private func userDocument(userId: String) -> DocumentReference {
        usersCollection.document(userId)
    }
}
