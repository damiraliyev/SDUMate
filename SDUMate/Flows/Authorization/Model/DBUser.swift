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

enum Faculty: String, CaseIterable {
    case none
    case engineeringAndNatScience = "Faculty of Engineering and natural sciences Computer Science and Information systems"
    case businessSchool = "Business school"
}

enum StudyProgram: String, CaseIterable {
    case none
    case computerScience = "Computer Science"
    case informationSystems = "Information Systems"
}

struct DBUser: Codable {
    let userId: String
    let email: String
    let isVerified: Bool
    let dateCreated: Date
    let isFullyAuthorized: Bool
    let userType: UserType
    let name: String?
    let surname: String?
    let nickname: String?
    let telegramTag: String?
    let faculty: Faculty?
    let studyProgram: StudyProgram?
    let yearOfEntering: Int?
    var profileImagePath: String?
    var profileImageUrl: String?
    var rating: Double
    var points: Int
    var numberOfProvidedHelp: Int
    var reviewsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email
        case isVerified = "is_verified"
        case dateCreated = "date_created"
        case isFullyAuthorized = "is_fully_authorized"
        case userType = "user_type"
        case name, surname, nickname
        case telegramTag = "telegram_tag"
        case faculty
        case studyProgram = "study_program"
        case yearOfEntering = "year_of_entering"
        case profileImagePath = "profile_image_path"
        case profileImageUrl = "profile_image_url"
        case rating
        case points
        case numberOfProvidedHelp = "number_of_provided_help"
        case reviewsCount = "reviews_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decode(String.self, forKey: .email)
        self.isVerified = try container.decode(Bool.self, forKey: .isVerified)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
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
        self.yearOfEntering  = try container.decodeIfPresent(Int.self, forKey: .yearOfEntering)
        self.profileImagePath = try container.decodeIfPresent(String.self, forKey: .profileImagePath)
        self.profileImageUrl = try container.decodeIfPresent(String.self, forKey: .profileImageUrl)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 5.0
        self.points = try container.decodeIfPresent(Int.self, forKey: .points) ?? 0
        self.numberOfProvidedHelp = try container.decodeIfPresent(Int.self, forKey: .numberOfProvidedHelp) ?? 0
        self.reviewsCount = try container.decodeIfPresent(Int.self, forKey: .reviewsCount) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.isVerified, forKey: .isVerified)
        try container.encode(self.dateCreated, forKey: .dateCreated)
        try container.encode(self.isFullyAuthorized, forKey: .isFullyAuthorized)
        try container.encode(self.userType.rawValue, forKey: .userType)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.surname, forKey: .surname)
        try container.encodeIfPresent(self.nickname, forKey: .nickname)
        try container.encodeIfPresent(self.telegramTag, forKey: .telegramTag)
        try container.encodeIfPresent(self.faculty?.rawValue, forKey: .faculty)
        try container.encodeIfPresent(self.studyProgram?.rawValue, forKey: .studyProgram)
        try container.encodeIfPresent(self.yearOfEntering, forKey: .yearOfEntering)
        try container.encodeIfPresent(self.profileImagePath, forKey: .profileImagePath)
        try container.encodeIfPresent(self.profileImageUrl, forKey: .profileImageUrl)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.points, forKey: .points)
        try container.encodeIfPresent(self.numberOfProvidedHelp, forKey: .numberOfProvidedHelp)
        try container.encodeIfPresent(self.reviewsCount, forKey: .reviewsCount)
    }
}

extension DBUser {
    
    init(authModel: AuthDataResultModel, userType: UserType) {
        self.userId = authModel.uid
        self.email = authModel.email ?? ""
        self.isVerified = false
        self.dateCreated = Date()
        self.isFullyAuthorized = false
        self.userType = userType
        self.name = nil
        self.surname = nil
        self.nickname = nil
        self.telegramTag = nil
        self.faculty = nil
        self.studyProgram = nil
        self.yearOfEntering = nil
        self.rating = 5.0
        self.points = 0
        self.numberOfProvidedHelp = 0
        self.reviewsCount = 0
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
        self.dateCreated = dateCreated.dateValue()
        self.isFullyAuthorized = dictionary["is_fully_authorized"] as? Bool ?? false
        self.userType = .none
        self.name = dictionary["name"] as? String
        self.surname = dictionary["surname"] as? String
        self.nickname = dictionary["nickname"] as? String
        self.telegramTag = dictionary["telegram_tag"] as? String
        let facultyRaw = dictionary["faculty"] as? String
        self.faculty = Faculty(rawValue: facultyRaw ?? "")
        let rawStudyProgram = dictionary["study_program"] as? String
        self.studyProgram = StudyProgram(rawValue: rawStudyProgram ?? "")
        self.yearOfEntering = dictionary["year_of_entering"] as? Int
        self.profileImageUrl = dictionary["profile_image_url"] as? String
        self.profileImagePath = dictionary["profile_image_path"] as? String
        self.rating = dictionary["rating"] as? Double ?? 5.0
        self.points = dictionary["points"] as? Int ?? 0
        self.numberOfProvidedHelp = 0
        self.reviewsCount = 0
    }
}
