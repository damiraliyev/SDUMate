//
//  User.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.03.2024.
//

import Foundation

struct DBUser {
    let userId: String
    let email: String
    let isVerified: Bool
    let photoUrl: String?
    let dateCreated: Date
}
