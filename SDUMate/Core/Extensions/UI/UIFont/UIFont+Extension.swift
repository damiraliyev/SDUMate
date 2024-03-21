//
//  UIFont+Extension.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 06.07.2023.
//

import UIKit

extension UIFont {
    
    private enum Constants {
        static let regular = "Poppins-Regular"
        static let medium = "Poppins-Medium"
        static let semibold = "Poppins-SemiBold"
        static let bold = "Poppins-Bold"
    }
    
    static let regular8 = UIFont(name: Constants.regular, size: 8)!
    static let regular13 = UIFont(name: Constants.regular, size: 13)!
    static let regular14 = UIFont(name: Constants.regular, size: 14)!
    static let regular16 = UIFont(name: Constants.regular, size: 16)!
    static let regular18 = UIFont(name: Constants.regular, size: 18)!
    
    static let medium12 = UIFont(name: Constants.medium, size: 12)!
    static let medium16 = UIFont(name: Constants.medium, size: 16)!
    static let medium18 = UIFont(name: Constants.medium, size: 18)!
    static let medium24 = UIFont(name: Constants.medium, size: 24)!
    static let medium36 = UIFont(name: Constants.medium, size: 36)
    
    static let semibold15 = UIFont(name: Constants.semibold, size: 15)
    static let semibold16 = UIFont(name: Constants.semibold, size: 16)
    
    static let bold14 = UIFont(name: Constants.bold, size: 14)!
    static let bold22 = UIFont(name: Constants.bold, size: 22)
    static let bold48 = UIFont(name: Constants.bold, size: 48)!
}
