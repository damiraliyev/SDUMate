//
//  UILabel+Extensions.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 16.11.2023.
//

import UIKit
import SkeletonView

extension UILabel {
    func setSkeleton(cornerRadius: Int = 0, numOfLines: SkeletonTextNumberOfLines = 1, lineHeight: SkeletonTextLineHeight = .relativeToFont, lastFillPercent: Int = 100) {
        self.isSkeletonable = true
        self.linesCornerRadius = cornerRadius
        self.skeletonTextNumberOfLines = numOfLines
        self.skeletonTextNumberOfLines = numOfLines
        self.skeletonTextLineHeight = lineHeight
        self.lastLineFillPercent = lastFillPercent
    }
}

