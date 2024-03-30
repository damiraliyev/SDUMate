//
//  ProfileSectionType.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import UIKit

enum ProfileSectionType: CaseIterable {
    case reviews
    case passwordAndHistory
    case aboutUs
    
    var numOfRows: Int {
        switch self {
        case .reviews:
            return 1
        case .passwordAndHistory:
            return 2
        case .aboutUs:
            return 3
        }
    }
    
    var items: [ProfileItemType] {
        switch self {
        case .reviews:              return [.reviews]
        case .passwordAndHistory:   return [.password, .history]
        case .aboutUs:              return [.aboutUs, .help, .termsAndPrivacy]
        }
    }
}

enum ProfileItemType {
    case reviews
    case password
    case history
    case aboutUs
    case help
    case termsAndPrivacy
    
    var title: String {
        switch self {
        case .reviews:          return "Reviews"
        case .password:         return "Password"
        case .history:          return "History"
        case .aboutUs:          return "About us"
        case .help:             return "Help"
        case .termsAndPrivacy:  return "Terms and privacy"
            
        }
    }
    
    var image: UIImage? {
        switch self {
        case .reviews:          return Asset.icPaperplane.image
        case .password:         return Asset.icLock.image
        case .history:          return Asset.icClock.image
        case .aboutUs:          return Asset.icAboutUs.image
        case .help:             return Asset.icQuestion.image
        case .termsAndPrivacy:  return Asset.icDocument.image
            
        }
    }
}
