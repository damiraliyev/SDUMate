//
//  Announcement.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

struct Announcement {
    let category: String
    let title: String
    let description: String
    let announcer: String
    let rating: String
    let reviewsCount: Int
    let price: String
    let creationDate: Date
    let isSessionEstablished: Bool
    let sessionEstablishedDate: Date?
    let recipient_id: String?
    let type: String
}

extension Announcement {
    init() {
        self.category = ""
        self.title = ""
        self.description = ""
        self.announcer = ""
        self.rating = ""
        self.reviewsCount = 0
        self.price = ""
        self.creationDate = Date()
        self.isSessionEstablished = false
        self.sessionEstablishedDate = nil
        self.recipient_id = nil
        self.type = ""
    }
}
