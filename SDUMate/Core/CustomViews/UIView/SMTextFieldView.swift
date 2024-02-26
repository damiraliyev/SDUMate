//
//  SMTextFieldView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 25.02.2024.
//

import UIKit

final class SMTextFieldView: UIView {
    
    private let leftImageView = UIImageView()
    
    private let mainTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = .medium16
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .textFieldInner
        leftImageView.contentMode = .scaleAspectFit
        layer.borderWidth = 1
        layer.borderColor = UIColor.textFieldBorderPurple.cgColor
        layer.cornerRadius = 20
        addSubviews([leftImageView, mainTextField])
    }
    
    private func setupConstraints() {
        leftImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(19.5)
            make.size.equalTo(15)
        }
        mainTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(leftImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(24)
        }
    }
    
    func setLeftImage(image: UIImage) {
        leftImageView.image = image
    }
    
    func setPlaceholderText(text: String) {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.medium16, .foregroundColor: UIColor.lavender]
        let attributedPlaceholder = NSAttributedString(string: text, attributes: placeholderAttributes)
        mainTextField.attributedPlaceholder = attributedPlaceholder
    }
    
    func makeTextSecure() {
        mainTextField.isSecureTextEntry = true
    }
}
