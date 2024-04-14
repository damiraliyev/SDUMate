//
//  Feedback.swift
//  SDUMate
//
//  Created by Damir Aliyev on 12.04.2024.
//

import Foundation

struct Feedback: Codable {
    var id: String
    let reviewerId: String?
    let reviewer: DBUser?
    let createdDate: String?
    let rating: Double
    let description: String?
}

extension Feedback {
    init(from dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.reviewerId = dict["reviewer_id"] as? String
        self.reviewer = dict["reviewer"] as? DBUser
        self.createdDate = dict["created_date"] as? String
        self.rating = dict["rating"] as? Double ?? 0
        self.description = dict["description"] as? String
    }
}
