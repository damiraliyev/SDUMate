//
//  AuthManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 06.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum FirebaseError: Error {
    case unknownError
}

enum SMError: Error {
    case needEmailToBeVerified
    
    var localizedDescription: String {
        switch self {
        case .needEmailToBeVerified: return "You need to verify your email before signing in."
        }
    }
}

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
    
    func createUser(email: String, password: String, completion: @escaping (Result<AuthDataResultModel, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let result = result, error == nil else {
                completion(.failure(error ?? FirebaseError.unknownError))
                return
            }
            let authModel = AuthDataResultModel(user: result.user)
            completion(.success(authModel))
        }
    }
    
    func sendVerificationMail(completion: @escaping ((Error?) -> Void)) {
        Auth.auth().currentUser?.sendEmailVerification(completion: completion)
    }
    
    func login(email: String, password: String, completion: @escaping (Result<AuthDataResultModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let result = result, error == nil else {
                completion(.failure(error ?? FirebaseError.unknownError))
                return
            }
            if !result.user.isEmailVerified {
                completion(.failure(SMError.needEmailToBeVerified))
                return
            } else {
                Firestore.firestore().collection("users").document(result.user.uid).updateData(["is_verified": true])
            }
            let authModel = AuthDataResultModel(user: result.user)
            completion(.success(authModel))
        }
    }
    
    func getAuthenticatedUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
    }
}
