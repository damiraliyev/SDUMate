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
    
    func createNewUser(authModel: AuthDataResultModel, completion: @escaping ((Error?) -> Void)) {
        guard let user = Auth.auth().currentUser, let email = authModel.email else { return }
        var userData: [String: Any] = [
            "user_id": authModel.uid,
            "date_created": Timestamp(),
            "email": email,
            "is_verified": user.isEmailVerified
        ]
        if let photoUrl = authModel.photoUrl {
            userData["photoUrl"] = photoUrl
        }
        Firestore.firestore().collection("users").document(authModel.uid).setData(userData, merge: false, completion: completion)
    }
}
