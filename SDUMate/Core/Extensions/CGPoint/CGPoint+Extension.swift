//
//  CGPoint+Extension.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 30.11.2023.
//

import Foundation

extension CGPoint {
    static let topLeft = CGPoint(x: 0, y: 0)
    static let top = CGPoint(x: 0.5, y: 0)
    static let topRight = CGPoint(x: 1, y: 0)
    static let centerLeft = CGPoint(x: 0, y: 0.5)
    static let center = CGPoint(x: 0.5, y: 0.5)
    static let centerRight = CGPoint(x: 1, y: 0.5)
    static let bottomLeft = CGPoint(x: 0, y: 1.0)
    static let bottom = CGPoint(x: 0.5, y: 1.0)
    static let bottomRight = CGPoint(x: 1, y: 1)
}
