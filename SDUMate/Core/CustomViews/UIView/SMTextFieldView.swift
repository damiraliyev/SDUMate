//
//  SMTextFieldView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 25.02.2024.
//

import UIKit
import SnapKit

final class SMTextFieldView: UIView {
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let mainTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = .medium16
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    private var textFieldLeadingConstraints: Constraint?
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.safeHide()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureTextFieldsLeading()
    }
    
    private func setupViews() {
        backgroundColor = .textFieldInner
        layer.borderWidth = 1
        layer.borderColor = UIColor.textFieldBorderPurple.cgColor
        layer.cornerRadius = 20
        addSubviews([leftImageView, mainTextField, rightImageView])
    }
    
    private func setupConstraints() {
        leftImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(19.5)
            make.size.equalTo(15)
        }
        mainTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            textFieldLeadingConstraints = make.leading.equalTo(leftImageView.snp.trailing).offset(10).constraint
            make.trailing.equalToSuperview().offset(-38)
            make.height.equalTo(24)
        }
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(15)
        }
    }
    
    func setLeftImage(image: UIImage) {
        leftImageView.image = image
    }
    
    func setRightImage(image: UIImage) {
        rightImageView.image = image
    }
    
    func setPlaceholderText(text: String, textColor: UIColor = .lavender.withAlphaComponent(0.4)) {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.medium16, .foregroundColor: textColor]
        let attributedPlaceholder = NSAttributedString(string: text, attributes: placeholderAttributes)
        mainTextField.attributedPlaceholder = attributedPlaceholder
    }
    
    func makeTextSecure() {
        mainTextField.isSecureTextEntry = true
    }
    
    func addRightImageView(image: UIImage) {
        rightImageView.image = image
        rightImageView.safeShow()
    }
    
    private func configureTextFieldsLeading() {
        if leftImageView.image == nil {
            textFieldLeadingConstraints?.update(offset: -15)
        }
    }
}
