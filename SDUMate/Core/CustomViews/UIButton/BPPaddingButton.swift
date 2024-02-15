//
//  BPPaddingButton.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 13.07.2023.
//

import UIKit

public class BPPaddingButton: UIButton {

    private let insets: UIEdgeInsets

    public init(inset: CGFloat) {
        self.insets = UIEdgeInsets(top: -inset, left: -inset, bottom: -inset, right: -inset)
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: insets).contains(point)
    }
}
