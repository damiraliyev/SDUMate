//
//  InvitationStatus.swift
//  SDUMate
//
//  Created by Damir Aliyev on 07.04.2024.
//

import UIKit

enum InvitationStatus: String {
    case pending
    case accepted
    case rejected
    case withdrawn
    
    var description: String {
        switch self {
        case .pending:      return ""
        case .accepted:     return "Go to session"
        case .rejected:     return "Rejected"
        case .withdrawn:    return "Withrawn"
        }
    }
    
    var descriptionColor: UIColor {
        switch self {
        case .pending:   return .lavender
        case .accepted:  return .orange
        case .rejected:  return ._FF5353
        case .withdrawn: return ._FF5353
        }
    }
    
    var image: UIImage? {
        switch self {
        case .pending:   return Asset.icClockLavender.image
        case .accepted:  return Asset.icDoubleAcceptance.image
        case .rejected:  return Asset.icRejectX.image
        case .withdrawn: return nil
            
        }
    }
}
