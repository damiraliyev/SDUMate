//
//  SMNavigationBar.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import UIKit
import SnapKit

public final class SMNavigationBar: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .dark
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .medium18
        return label
    }()
    private lazy var returnButton: BPPaddingButton = {
        let btn = BPPaddingButton(inset: 16)
        let image = Asset.icBackButton.image
        btn.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.tintColor = .dark
        btn.addTarget(self, action: #selector(returnTapped), for: .touchUpInside)
        return btn
    }()
    private lazy var rightButton: BPPaddingButton = {
        let btn = BPPaddingButton(inset: 16)
        let image = Asset.icBackButton.image
        btn.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.tintColor = .dark
        btn.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        return btn
    }()

    private let tapCallback: (() -> Void)?
    private let rightBtnTapCallback: (() -> Void)?
    
    public var trailingConstraint: Constraint?

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var font: UIFont? {
        didSet {
            titleLabel.font = font
        }
    }
    
    public var rightButtonIcon: UIImage? {
        didSet {
            rightButton.setImage(rightButtonIcon, for: .normal)
        }
    }
    
    public var isRightButtonHidden: Bool = true {
        didSet {
            rightButton.isHidden = isRightButtonHidden
        }
    }

    public var isBackButtonHidden: Bool = false {
        didSet {
            returnButton.isHidden = isBackButtonHidden
        }
    }
    
    public var backButtonColor: UIColor? {
        didSet {
            returnButton.tintColor = backButtonColor
        }
    }
    
    public var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor
        }
    }

    public init(_ backgroundColor: UIColor = .clear, title: String, tapCallback: (() -> Void)?, rightBtnTapCallback: (() -> Void)? = nil) {
        self.tapCallback = tapCallback
        self.rightBtnTapCallback = rightBtnTapCallback
        super.init(frame: CGRect(x: 0,
                                 y: UIView.safeTopAreaHeight,
                                 width: UIView.screenWidth,
                                 height: 50))
        self.backgroundColor = backgroundColor
        titleLabel.text = title
        titleLabel.adjustsFontSizeToFitWidth = true
        setupViews()
        rightButton.isHidden = isRightButtonHidden
    }

    private func setupViews() {
        addSubview(returnButton)
        returnButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(30)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(returnButton.snp.trailing).offset(4)
            trailingConstraint = make.trailing.equalToSuperview().inset(38).constraint
        }
        
        addSubview(rightButton)
        rightButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
            $0.size.equalTo(30)
        }
    }

    @objc private func returnTapped() {
        tapCallback?()
    }
    
    @objc private func rightButtonTapped() {
        rightBtnTapCallback?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
