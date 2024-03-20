//
//  UserInfo.swift
//  SDUMate
//
//  Created by Damir Aliyev on 10.03.2024.
//

import Foundation

final class UserInfo: Encodable {
    var name: String?
    var surname: String?
    var nickname: String?
    var telegramTag: String?
    var faculty: Faculty?
    var studyProgram: StudyProgram?
    var yearOfEntering: Int?
    var profileImagePath: String?
    var profileImageUrl: String?
    var isFullyAuthorized: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name, surname, nickname
        case telegramTag = "telegram_tag"
        case faculty
        case studyProgram = "study_program"
        case yearOfEntering = "year_of_entering"
        case profileImagePath = "profile_image_path"
        case profileImageUrl = "profile_image_url"
        case isFullyAuthorized = "is_fully_authorized"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.surname, forKey: .surname)
        try container.encode(self.nickname, forKey: .nickname)
        try container.encode(self.telegramTag, forKey: .telegramTag)
        try container.encode(self.faculty?.rawValue, forKey: .faculty)
        try container.encode(self.studyProgram?.rawValue, forKey: .studyProgram)
        try container.encode(self.yearOfEntering, forKey: .yearOfEntering)
        try container.encode(self.profileImagePath, forKey: .profileImagePath)
        try container.encode(self.profileImageUrl, forKey: .profileImageUrl)
        try container.encode(self.isFullyAuthorized, forKey: .isFullyAuthorized)
    }
}
