//
//  Animations.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 20.09.2023.
//

import UIKit
 
enum AnimationEdge {
    case none
    case top
    case bottom
    case left
    case right
}

extension UIView {
    @discardableResult
    func shake(toward edge: AnimationEdge = .left,
               amount: CGFloat = 0.05,
               duration: TimeInterval = 0.5,
               delay: TimeInterval = 0,
               completion: ((Bool) -> Void)? = nil) -> UIView {
        let steps = 8
        let timeStep = 1.0 / Double(steps)
        var dx: CGFloat, dy: CGFloat
        if edge == .left || edge == .right {
            dx = (edge == .left ? -1 : 1) * self.bounds.size.width * amount
            dy = 0
        } else {
            dx = 0
            dy = (edge == .top ? -1 : 1) * self.bounds.size.height * amount
        }
        UIView.animateKeyframes(
            withDuration: duration, delay: delay, options: .calculationModeCubic, animations: {
                var start = 0.0
                for i in 0..<(steps - 1) {
                    UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: timeStep) {
                        self.transform = CGAffineTransform(translationX: dx, y: dy)
                    }
                    if edge == .none && i % 2 == 0 {
                        swap(&dx, &dy)  // Change direction
                        dy *= -1
                    }
                    dx *= -0.85
                    dy *= -0.85
                    start += timeStep
                }
                UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: timeStep) {
                    self.transform = .identity
                }
            }, completion: completion)
        return self
    }
    
}

