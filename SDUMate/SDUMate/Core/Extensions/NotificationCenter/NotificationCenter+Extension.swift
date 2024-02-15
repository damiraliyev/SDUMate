//
//  NotificationCenter+Extension.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 05.07.2023.
//

import Foundation

public extension NotificationCenter {
    func setObserver(_ observer: AnyObject, selector: Selector, name: NSNotification.Name, object: AnyObject?) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
}

public extension Notification.Name {
    static let languageDidChange = Notification.Name("LanguageDidChange")
    static let setGradient = Notification.Name("setGradient")
}
