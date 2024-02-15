//
//  UIStackView+Extension.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 10.07.2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach( { addArrangedSubview($0)})
    }
    
    func removeArrangedSubviewCompletely(_ subview: UIView) {
        removeArrangedSubview(subview)
        subview.removeFromSuperview()
    }
    
    func removeArrangedSubviewsCompletely() {
        arrangedSubviews.reversed().forEach { removeArrangedSubviewCompletely($0)}
    }
}
