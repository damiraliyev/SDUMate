//
//  CategoryFilter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 24.03.2024.
//

import Foundation

enum AnnounceType {
    case offer
    case request
    case collaborate
    
    var title: String {
        switch self {
        case .offer:        return "Offer"
        case .request:      return "Request"
        case .collaborate:  return "Collaborate"
        }
    }
}
