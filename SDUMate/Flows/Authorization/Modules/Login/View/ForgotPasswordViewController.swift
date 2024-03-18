//
//  ForgotPasswordView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 18.03.2024.
//

import UIKit

final class ForgotPasswordViewController: BaseViewController {
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium36
        label.text = "Forgot password?"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lavender
        label.font = .medium16
        label.text = "Enter your email for the verification process, we will send code to your email"
        label.numberOfLines = 0
        return label
    }()
    
    private let emailFieldView: SMTextFieldView = {
        let fieldView = SMTextFieldView()
        fieldView.setPlaceholderText(text: "id or email")
        fieldView.setLeftImage(image: Asset.icEnvelope.image)
        return fieldView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubviews([labelsStackView, emailFieldView])
        labelsStackView.addArrangedSubviews([forgotPasswordLabel, descriptionLabel])
    }
    
    private func setupConstraints() {
        labelsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-36)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        emailFieldView.snp.makeConstraints { make in
            make.top.equalTo(labelsStackView.snp.bottom).offset(58)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(54)
        }
        
    }
}
