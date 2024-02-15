//
//  UIFont+Extension.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 06.07.2023.
//

import UIKit

extension UIFont {
    static let regular8 = UIFont(name: "SamsungSans-Regular", size: 8)!
    static let regular10 = UIFont(name: "SamsungSans-Regular", size: 10)!
    static let regular12 = UIFont(name: "SamsungSans-Regular", size: 12)!
    static let regular13 = UIFont(name: "SamsungSans-Regular", size: 13)!
    static let regular14 = UIFont(name: "SamsungSans-Regular", size: 14)!
    static let regular15 = UIFont(name: "SamsungSans-Regular", size: 15)!
    static let regular16 = UIFont(name: "SamsungSans-Regular", size: 16)!
    static let regular20 = UIFont(name: "SamsungSans-Regular", size: 20)!
    static let regular23 = UIFont(name: "SamsungSans-Regular", size: 23)!
    static let regular24 = UIFont(name: "SamsungSans-Regular", size: 24)!
    static let regular34 = UIFont(name: "SamsungSans-Bold", size: 34)!
    
    static let medium10 = UIFont(name: "SamsungSans-Medium", size: 10)!
    static let medium12 = UIFont(name: "SamsungSans-Medium", size: 12)!
    static let medium14 = UIFont(name: "SamsungSans-Medium", size: 14)!
    static let medium16 = UIFont(name: "SamsungSans-Medium", size: 16)!
    static let medium17 = UIFont(name: "SamsungSans-Medium", size: 17)!
    static let medium18 = UIFont(name: "SamsungSans-Medium", size: 18)!
    static let medium20 = UIFont(name: "SamsungSans-Medium", size: 20)!
    static let medium22 = UIFont(name: "SamsungSans-Medium", size: 22)!
    static let medium24 = UIFont(name: "SamsungSans-Medium", size: 24)!
    
    static let bold8 = UIFont(name: "SamsungSans-Bold", size: 8)!
    static let bold10 = UIFont(name: "SamsungSans-Bold", size: 10)!
    static let bold12 = UIFont(name: "SamsungSans-Bold", size: 12)!
    static let bold14 = UIFont(name: "SamsungSans-Bold", size: 14)!
    static let bold16 = UIFont(name: "SamsungSans-Bold", size: 16)!
    static let bold18 = UIFont(name: "SamsungSans-Bold", size: 18)!
    static let bold20 = UIFont(name: "SamsungSans-Bold", size: 20)!
    static let bold22 = UIFont(name: "SamsungSans-Bold", size: 22)!
    static let bold24 = UIFont(name: "SamsungSans-Bold", size: 24)!

    static func loadFonts() {
        registerFont(withName: "SamsungSans-Regular", fileExtension: "ttf")
        registerFont(withName: "SamsungSans-Medium", fileExtension: "ttf")
        registerFont(withName: "SamsungSans-Bold", fileExtension: "ttf")
    }
    
    static func registerFont(withName name: String, fileExtension: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
            return
        }
        guard let fontDataProvider = CGDataProvider(url: url as CFURL) else {
            return
        }
        guard let font = CGFont(fontDataProvider) else {
            return
        }
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
//            print(error!.takeUnretainedValue())
            return
        }
    }
}
