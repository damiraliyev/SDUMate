//
//  AnnouncementCategory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.05.2024.
//

import UIKit

enum AnnouncementCategory: String {
    case softwareDevelopment = "Software Development"
    case math = "Math"
    case dataAnalysis = "Data Analysis"
    case languages = "Languages"
    case literature = "Literature"
    case biology = "Biology"
    case chemistry = "Chemistry"
    case others = "Others"
    
    var title: String {
        switch self {
        case .softwareDevelopment:
            return "Software Development"
        case .math:
            return "Math"
        case .dataAnalysis:
            return "Data Analysis"
        case .languages:
            return "Languages"
        case .literature:
            return "Literature"
        case .biology:
            return "Biology"
        case .chemistry:
            return "Chemistry"
        case .others:
            return "Others"
        }
    }
    
    var image: UIImage {
        switch self {
        case .softwareDevelopment:
            return Asset.icSoftware.image
        case .math:
            return Asset.icMath.image
        case .dataAnalysis:
            return Asset.icDataAnalysis.image
        case .languages:
            return Asset.icLanguage.image
        case .literature:
            return Asset.icLiterature.image
        case .biology:
            return Asset.icBiology.image
        case .chemistry:
            return Asset.icChemistry.image
        case .others:
            return Asset.icOthers.image
        }
    }
}
