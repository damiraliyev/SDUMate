//
//  EditProfileTableSectionType.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import Foundation

enum EditProfileTableSectionType: CaseIterable {
    case about
    case contact
    case study
    
    var title: String {
        switch self {
        case .about:    return "About"
        case .contact:  return "Contact"
        case .study:    return "Study"
            
        }
    }
    
    var items: [EditProfileTableItem] {
        switch self {
        case .about:    return [.name, .surname, .nickname]
        case .contact:  return [.telegram, .email]
        case .study:    return [.faculty, .profession, .yearOfEntering]
        }
    }
}

enum EditProfileTableItem {
    case name
    case surname
    case nickname
    case telegram
    case email
    case faculty
    case profession
    case yearOfEntering
    
    var title: String {
        switch self {
        case .name:             return "Name"
        case .surname:          return "Surname"
        case .nickname:         return "Nickname"
        case .telegram:         return "Telegram"
        case .email:            return "Email"
        case .faculty:          return "Faculty"
        case .profession:       return "Profession"
        case .yearOfEntering:   return "Year of entering"
        }
    }
}
