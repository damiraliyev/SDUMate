//
//  TabBarItem.swift
//  SDUMate
//
//  Created by Damir Aliyev on 20.03.2024.
//

import Foundation

import Foundation

enum OwnerTabBarItem {
    case home
    case sessions
    case newRequest
    case rating
    case settings
    
    var index: Int {
        switch self {
        case .home:        return 0
        case .sessions:    return 1
        case .newRequest:  return 2
        case .rating:      return 3
        case .settings:    return 4
        }
    }
}
