//
//  User.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.03.2024.
//

import Foundation
import Firebase

enum UserType: String {
    case student
    case alumni
    case none
}

enum Faculty: String {
    case none
    case engineeringAndNatScience
}

enum StudyProgram: String {
    case none
    case computerScience
    case informationSystems
}

struct DBUser: Codable {
    let userId: String
    let email: String
    let isVerified: Bool
    let photoUrl: String?
    let dateCreated: Date
    let isFullyAuthorized: Bool
    let userType: UserType
    let name: String?
    let surname: String?
    let nickname: String?
    let telegramTag: String?
    let faculty: Faculty?
    let studyProgram: StudyProgram?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email
        case isVerified = "is_verified"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case isFullyAuthorized = "is_fully_authorized"
        case userType = "user_type"
        case name, surname, nickname
        case telegramTag = "telegram_tag"
        case faculty
        case studyProgram = "study_program"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decode(String.self, forKey: .email)
        self.isVerified = try container.decode(Bool.self, forKey: .isVerified)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.isFullyAuthorized = try container.decode(Bool.self, forKey: .isFullyAuthorized)
        let rawType = try container.decode(String.self, forKey: .userType)
        self.userType = UserType(rawValue: rawType) ?? .student
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.surname = try container.decodeIfPresent(String.self, forKey: .surname)
        self.nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
        self.telegramTag = try container.decodeIfPresent(String.self, forKey: .telegramTag)
        let rawFaculty = try container.decodeIfPresent(String.self, forKey: .faculty)
        self.faculty = Faculty(rawValue: rawFaculty ?? "") ?? Faculty.none
        let rawStudyProgram = try container.decodeIfPresent(String.self, forKey: .studyProgram)
        self.studyProgram = StudyProgram(rawValue: rawStudyProgram ?? "") ?? StudyProgram.none
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.isVerified, forKey: .isVerified)
        try container.encode(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encode(self.isFullyAuthorized, forKey: .isFullyAuthorized)
        try container.encode(self.userType.rawValue, forKey: .userType)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.surname, forKey: .surname)
        try container.encodeIfPresent(self.nickname, forKey: .nickname)
        try container.encodeIfPresent(self.telegramTag, forKey: .telegramTag)
        try container.encodeIfPresent(self.faculty?.rawValue, forKey: .faculty)
        try container.encodeIfPresent(self.studyProgram?.rawValue, forKey: .studyProgram)
    }
}

extension DBUser {
    
    init(authModel: AuthDataResultModel, userType: UserType) {
        self.userId = authModel.uid
        self.email = authModel.email ?? ""
        self.isVerified = false
        self.photoUrl = authModel.photoUrl
        self.dateCreated = Date()
        self.isFullyAuthorized = false
        self.userType = userType
        self.name = nil
        self.surname = nil
        self.nickname = nil
        self.telegramTag = nil
        self.faculty = nil
        self.studyProgram = nil
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
        self.userType = .none
        self.name = nil
        self.surname = nil
        self.nickname = nil
        self.telegramTag = nil
        self.faculty = nil
        self.studyProgram = nil
    }
}
