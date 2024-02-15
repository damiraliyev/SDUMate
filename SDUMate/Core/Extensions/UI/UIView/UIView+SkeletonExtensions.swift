//
//  UIView+SkeletonExtensions.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 16.11.2023.
//

import UIKit
import SkeletonView

extension UIView {
    func showSkeletonLoading(baseColor: UIColor = .skeletonColor) {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        self.showAnimatedGradientSkeleton(
            usingGradient: SkeletonGradient(baseColor: baseColor),
            animation: animation,
            transition: .crossDissolve(0.25)
        )
    }
}
