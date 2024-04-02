//
//  Announcement.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

struct Announcement {
    var id: String
    var category: String
    var title: String
    var description: String
    var announcerId: String
    var announcer: DBUser? = nil
    var price: String
    var creationDate: String
    var isSessionEstablished: Bool
    var sessionEstablishedDate: String?
    var respondentId: String?
    var respondent: DBUser? = nil
    var type: AnnounceType
}

extension Announcement {
    init() {
        self.id = ""
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
        self.id = dict["id"] as? String ?? ""
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


struct Invitation: Encodable {
    var id: String
    let createdDate: String
    let announcerId: String
    let respondentId: String
    let announcementId: String
    let status: String
    var announcer: DBUser? = nil
    var respondent: DBUser? = nil
    var announcement: Announcement? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdDate = "created_date"
        case announcerId = "announcer_id"
        case respondentId = "respondent_id"
        case announcementId = "announcement_id"
        case status, announcer, respondent, announcement
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.createdDate, forKey: .createdDate)
        try container.encode(self.announcerId, forKey: .announcerId)
        try container.encode(self.respondentId, forKey: .respondentId)
        try container.encode(self.announcementId, forKey: .announcementId)
        try container.encode(self.status, forKey: .status)
    }
}

extension Invitation {
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.createdDate = dict["created_date"] as? String ?? ""
        self.announcerId = dict["announcer_id"] as? String ?? ""
        self.respondentId = dict["respondent_id"] as? String ?? ""
        self.announcementId = dict["announcement_id"] as? String ?? ""
        self.status = dict["status"] as? String ?? ""
    }
}
