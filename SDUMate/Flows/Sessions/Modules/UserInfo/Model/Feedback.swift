//
//  Feedback.swift
//  SDUMate
//
//  Created by Damir Aliyev on 12.04.2024.
//

import Foundation

struct Feedback {
    let id: String
    let reviewerId: String?
    let reviewer: DBUser?
    let createdDate: String?
    let rating: Double
    let description: String?
}
