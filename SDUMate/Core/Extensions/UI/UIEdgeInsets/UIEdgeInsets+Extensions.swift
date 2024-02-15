//
//  UIEdgeInsets+Extensions.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 18.10.2023.
//

import UIKit
 
extension UIEdgeInsets {
    static func make(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
