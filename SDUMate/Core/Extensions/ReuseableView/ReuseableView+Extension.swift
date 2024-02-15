//
//  ReuseableView+Extension.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 10.07.2023.
//

import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
