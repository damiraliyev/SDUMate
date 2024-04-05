//
//  Announcement.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

struct Announcement: Codable {
    var id: String
    var category: String
    var title: String
    var description: String
    var announcerId: String
    var announcer: DBUser? = nil
    var price: String
    var createdDate: String
    var isSessionEstablished: Bool
    var sessionEstablishedDate: String?
    var respondentId: String?
    var respondent: DBUser? = nil
    var type: AnnounceType
    
    enum CodingKeys: String, CodingKey {
        case id
        case category
        case title
        case description
        case announcerId = "announcer_id"
        case announcer
        case price
        case creationDate = "creation_date"
        case isSessionEstablished = "is_session_established"
        case sessionEstablishedDate = "session_established_date"
        case respondentId = "respondent_id"
        case respondent
        case type
    }
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
        self.createdDate = ""
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
        self.createdDate = dict["created_date"] as? String ?? ""
        self.isSessionEstablished = dict["is_session_established"] as? Bool ?? false
        self.sessionEstablishedDate = dict["session_established_date"] as? String ?? ""
        self.respondentId = dict["respondent_id"] as? String
        self.respondent = nil
        let typeRawValue = dict["type"] as? String
        self.type = AnnounceType(rawValue: typeRawValue ?? "") ?? .request
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.category = try container.decode(String.self, forKey: .category)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.announcerId = try container.decode(String.self, forKey: .announcerId)
        self.announcer = try container.decodeIfPresent(DBUser.self, forKey: .announcer)
        self.price = try container.decode(String.self, forKey: .price)
        self.createdDate = try container.decode(String.self, forKey: .creationDate)
        self.isSessionEstablished = try container.decode(Bool.self, forKey: .isSessionEstablished)
        self.sessionEstablishedDate = try container.decode(String.self, forKey: .sessionEstablishedDate)
        self.respondentId = try container.decodeIfPresent(String.self, forKey: .respondentId)
        self.respondent = try container.decodeIfPresent(DBUser.self, forKey: .respondent)
        let typeRawValue = try container.decode(String.self, forKey: .type)
        self.type = AnnounceType(rawValue: typeRawValue) ?? .request
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(category, forKey: .category)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(announcerId, forKey: .announcerId)
        try container.encodeIfPresent(announcer, forKey: .announcer)
        try container.encode(price, forKey: .price)
        try container.encode(createdDate, forKey: .creationDate)
        try container.encode(isSessionEstablished, forKey: .isSessionEstablished)
        try container.encode(sessionEstablishedDate, forKey: .sessionEstablishedDate)
        try container.encodeIfPresent(respondentId, forKey: .respondentId)
        try container.encodeIfPresent(respondent, forKey: .respondent)
        try container.encode(type.rawValue, forKey: .type)
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
