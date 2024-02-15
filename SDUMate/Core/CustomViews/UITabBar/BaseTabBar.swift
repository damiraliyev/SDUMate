//
//  BaseTabBar.swift
//  BePRO
//
//  Created by Damir Aliyev on 27.10.2023.
//

import UIKit

final class BaseTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = GlobalConstants.tabBarHeight
        return sizeThatFits
    }
}
