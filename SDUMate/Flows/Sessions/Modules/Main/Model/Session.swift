//
//  Session.swift
//  SDUMate
//
//  Created by Damir Aliyev on 07.04.2024.
//

import Foundation

enum SessionStatus: String {
    case active
    case finished
}

struct Session: Codable {
    let id: String
    let announcerId: String
    let respondentId: String
    let announcementId: String
    let announceType: AnnounceType
    let status: SessionStatus
    var announcer: DBUser?
    var respondent: DBUser?
    var announcement: Announcement?
    var createdDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case announcerId = "announcer_id"
        case respondentId = "respondent_id"
        case announcementId = "announcement_id"
        case announceType = "announce_type"
        case status = "status"
        case createdDate = "created_date"
    }
    
    static func decodeSession(from dictionary: [String: Any]) throws -> Session {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary)
        
        let decoder = JSONDecoder()
        
        let session = try decoder.decode(Session.self, from: jsonData)
        return session
    }
}

extension Session {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        announcerId = try container.decode(String.self, forKey: .announcerId)
        respondentId = try container.decode(String.self, forKey: .respondentId)
        announcementId = try container.decode(String.self, forKey: .announcementId)
        let announceTypeRawValue = try container.decode(String.self, forKey: .announceType)
        let statusRawValue = try container.decode(String.self, forKey: .status)
        self.announceType = AnnounceType(rawValue: announceTypeRawValue) ?? .request
        self.status = SessionStatus(rawValue: statusRawValue) ?? .finished
        self.createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
    }
}

extension Session {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(announcerId, forKey: .announcerId)
        try container.encode(respondentId, forKey: .respondentId)
        try container.encode(announcementId, forKey: .announcementId)
        try container.encode(announceType.rawValue, forKey: .announceType)
        try container.encode(status.rawValue, forKey: .status)
        try container.encode(createdDate, forKey: .createdDate)
    }
}
