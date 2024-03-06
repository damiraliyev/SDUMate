//
//  AuthManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 06.03.2024.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthManager {
    
    static let shared = AuthManager()
    private init() {}
    
    func createUser(email: String, password: String, completion: @escaping (AuthDataResultModel?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let result = result, error == nil else {
                completion(nil)
                return
            }
            let authModel = AuthDataResultModel(user: result.user)
            completion(authModel)
        }
    }
}
