import Foundation

public enum AppLanguage: String, CaseIterable {
    case kk
    case ru
    case en
    
    static let `default` = AppLanguage.kk

    var locale: Locale {
        Locale(identifier: localeRawValue)
    }
    
    var fileName: String {
        switch self {
        case .kk:       return "kk-KZ"
        case .ru:       return "ru"
        case .en:       return "en"
        }
    }
}

public extension AppLanguage {
    static var preferred: [String] {
        [UserSettings().appLanguage.localeRawValue]
    }
}

public extension AppLanguage {
    var title: String {
        switch self {
        case .kk:   return "Қазақша"
        case .ru:   return "Русский"
        case .en:   return "English"
        }
    }
    
    var shortTitle: String {
        switch self {
        case .kk:   return "ҚАЗ"
        case .ru:   return "РУC"
        case .en:   return "ENG"
        }
    }
    
    var headerLanguage: String {
        switch self {
        case .kk:   return "kk"
        case .ru:   return "ru"
        case .en:   return "en"
        }
    }
    
    var localeRawValue: String {
        switch self {
        case .kk: return "kk_KZ"
        case .ru: return "ru_RU"
        case .en: return "en_US"
        }
    }
}
