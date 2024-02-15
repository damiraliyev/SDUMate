//
//  UIScrollView+Extension.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 22.09.2023.
//

import UIKit

extension UIScrollView {
    func makeSubviewFullyVisible(_ view: UIView, padding: CGFloat = 30.0) {
        guard let superview = view.superview else { return }
        let rect = superview.convert(view.frame, to: self)

        if !self.bounds.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)).contains(rect) {
            if rect.origin.y < self.contentOffset.y {
                self.setContentOffset(CGPoint(x: 0, y: rect.origin.y - padding), animated: true)
            } else {
                let offset = rect.origin.y + rect.height - self.bounds.height + padding
                self.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
            }
        }
    }
}
