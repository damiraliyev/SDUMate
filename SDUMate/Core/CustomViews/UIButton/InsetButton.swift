//
//  InsetButton.swift
//  SDUMate
//
//  Created by Damir Aliyev on 22.03.2024.
//

import UIKit

final class InsetButton: UIButton {
    
    private let top: CGFloat
    private let leading: CGFloat
    private let bottom: CGFloat
    private let trailing: CGFloat
    
    init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
        super.init(frame: .zero)
        tintColor = .white
        configureInsets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureInsets() {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
            self.configuration = configuration
        } else {
            let titleInsets = UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing)
            contentEdgeInsets = titleInsets
        }
    }
}

