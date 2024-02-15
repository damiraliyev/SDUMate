//
//  UserSettings.swift
//  BePRO
//
//  Created by Sanzhar Dauylov on 25.01.2024.
//

import Foundation

struct UserSettings {
    
    @UserDefault("appLanguage")
    var appLanguage: AppLanguage = .default
    
    func setCurrentLanguage() {
        if let rawValue = Bundle.main.preferredLocalizations.first ?? Locale.current.languageCode,
           let appLanguage = AppLanguage(rawValue: rawValue) {
            self.appLanguage = appLanguage
        } else {
            self.appLanguage = .default
        }
    }
}
