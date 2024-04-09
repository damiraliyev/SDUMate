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
    
    var actionTitle: String {
        switch self {
        case .pending:      return "Withdraw"
        case .accepted:     return ""
        case .rejected:     return ""
        case .withdrawn:    return ""
        }
    }
    
    var actionTitleColor: UIColor {
        switch self {
        case .pending:   return ._FF5353
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
