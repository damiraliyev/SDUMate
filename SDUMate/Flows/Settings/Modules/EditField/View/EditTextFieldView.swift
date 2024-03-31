//
//  EditTextFieldView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import UIKit

final class EditTextFieldView: UIView {
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = .medium16
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.textContentType = .oneTimeCode
        return textField
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icDelete.image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        return button
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
        backgroundColor = ._767680.withAlphaComponent(0.2)
        addSubviews([textField, clearButton])
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(16)
            make.trailing.equalToSuperview().offset(-26)
        }
        clearButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-6.3)
            make.size.equalTo(18)
        }
    }
    
    func setPlaceholderText(text: String, textColor: UIColor = .lavender.withAlphaComponent(0.4)) {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.medium16, .foregroundColor: textColor]
        let attributedPlaceholder = NSAttributedString(string: text, attributes: placeholderAttributes)
        textField.attributedPlaceholder = attributedPlaceholder
    }
    
    func getText() -> String? {
        textField.text
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        
    }
    
    @objc func clearTapped() {
        textField.text = ""
    }
}
