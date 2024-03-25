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
    let announcerId: String
    var announcer: DBUser? = nil
    let price: String
    let creationDate: String
    let isSessionEstablished: Bool
    let sessionEstablishedDate: String?
    let respondentId: String?
    var respondent: DBUser? = nil
    let type: AnnounceType
}

extension Announcement {
    init() {
        self.category = ""
        self.title = ""
        self.description = ""
        self.announcerId = ""
        self.announcer = nil
        self.price = ""
        self.creationDate = ""
        self.isSessionEstablished = false
        self.sessionEstablishedDate = nil
        self.respondentId = nil
        self.respondent = nil
        self.type = .offer
    }
    
    init(dict: [String: Any]) {
        self.category = dict["category"] as? String ?? ""
        self.title = dict["title"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
        self.announcerId = dict["announcer_id"] as? String ?? ""
        self.announcer = nil
        self.price = dict["price"] as? String ?? ""
        self.creationDate = dict["creation_date"] as? String ?? ""
        self.isSessionEstablished = dict["is_session_established"] as? Bool ?? false
        self.sessionEstablishedDate = dict["session_established_date"] as? String ?? ""
        self.respondentId = dict["respondent_id"] as? String
        self.respondent = nil
        self.type = .offer
    }
}


struct Invitation {
    let createdDate: Date
    let announcerId: String
    let respondentId: String
    let announcementId: String
    let status: String
}
