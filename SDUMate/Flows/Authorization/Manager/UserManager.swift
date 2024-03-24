//
//  UserManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import PromiseKit

final class UserManager {
    
    static let shared = UserManager()
    
    private init() {}
    
    private let usersCollection = Firestore.firestore().collection("users")
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    func getUser(userId: String, completion: @escaping (Swift.Result<DBUser, Error>) -> Void) {
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
    
    func getUser(userId: String) -> Promise<DBUser> {
        return Promise<DBUser> { [weak self] seal in
            self?.userDocument(userId: userId).getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    seal.reject(error ?? URLError(.badServerResponse))
                    return
                }
                if let user = DBUser(dictionary: data) {
                    seal.fulfill(user)
                } else {
                    seal.reject(SMError.decodingError)
                }
            }
        }

    }
    
    private func userDocument(userId: String) -> DocumentReference {
        usersCollection.document(userId)
    }
    
    func addAdditionalUserInfo(userId: String, userInfo: UserInfo, completion: @escaping ((Error?) -> Void)) {
        let dict = userInfo.makeDictionary()
        userDocument(userId: userId).updateData(dict) { error in
            completion(error)
        }
    }
    
    func setProfileImage(userId: String, profileImagePath: String, profileImageUrl: String) -> Promise<Error?> {
        let dict = [
            "profile_image_path": profileImagePath,
            "profile_image_url": profileImageUrl
        ]
        return Promise { seal in
            userDocument(userId: userId).updateData(dict) { error in
                guard error == nil else {
                    seal.reject(error!)
                    return
                }
                seal.fulfill(nil)
            }
        }
    }
}
