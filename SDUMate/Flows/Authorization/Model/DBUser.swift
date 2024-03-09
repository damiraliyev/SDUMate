//
//  User.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.03.2024.
//

import Foundation
import Firebase

struct DBUser: Codable {
    let userId: String
    let email: String
    let isVerified: Bool
    let photoUrl: String?
    let dateCreated: Date
    let isFullyAuthorized: Bool
}

extension DBUser {
    
    init(authModel: AuthDataResultModel) {
        self.userId = authModel.uid
        self.email = authModel.email ?? ""
        self.isVerified = false
        self.photoUrl = authModel.photoUrl
        self.dateCreated = Date()
        self.isFullyAuthorized = false
    }
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["user_id"] as? String,
              let email = dictionary["email"] as? String,
              let isVerified = dictionary["is_verified"] as? Bool,
              let dateCreated = dictionary["date_created"] as? Timestamp else {
            return nil
        }
        self.userId = id
        self.email = email
        self.isVerified = isVerified
        self.photoUrl = dictionary["photo_url"] as? String
        self.dateCreated = dateCreated.dateValue()
        self.isFullyAuthorized = dictionary["is_fully_authorized"] as? Bool ?? false
    }
}
