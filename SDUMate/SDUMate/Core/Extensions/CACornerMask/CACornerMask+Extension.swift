//
//  CACornerMask+Extension.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 12.07.2023.
//

import QuartzCore

extension CACornerMask {
    
    static var allCases: Self {
        [.layerMinXMinYCorner, .layerMaxXMinYCorner,
                .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    static var top: Self {
        [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    static var bottom: Self {
        [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    static var left: Self {
        [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    static var right: Self {
        [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
}
