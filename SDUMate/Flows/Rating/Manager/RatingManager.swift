//
//  RatingManager.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.05.2024.
//

import Foundation
import FirebaseFirestore
import PromiseKit

final class RatingManager {
    static let shared = RatingManager()
    
    private init() {}
    
    private let usersCollection = Firestore.firestore().collection("users")
    
    func fetchAllUsers() -> Promise<[DBUser]> {
        return Promise<[DBUser]> { seal in
            usersCollection.getDocuments { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    seal.reject(error ?? URLError(.badServerResponse))
                    return
                }
                var users: [DBUser] = []
                for doc in snapshot.documents {
                    if let user = DBUser(dictionary: doc.data()) {
                        users.append(user)
                    }
                }
                seal.fulfill(users)
            }
        }
    }
}
