//
//  AttachmentOption.swift
//  SDUMate
//
//  Created by Damir Aliyev on 16.03.2024.
//

import Foundation

enum AttachmentOption: String, CaseIterable {
    case camera
    case photoLibrary
    
    var name: String {
        switch self {
        case .camera:           return "Camera"
        case .photoLibrary:     return "Photo library"
        }
    }
    
    var title: String? {
        switch self {
        case .camera:           return "Whoops! We can't access your camera";
        case .photoLibrary:     return "Whoops! We can't access your library";
        }
    }
    
    var message: String? {
        switch self {
        case .camera:           return "Go to Settings and turn on Camera";
        case .photoLibrary:     return "Go to Settings and turn on Photos";
        }
    }
}
