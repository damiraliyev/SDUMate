//
//  ForgotPasswordView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 18.03.2024.
//

import UIKit

protocol IForgotPasswordView: Presentable {
    var presenter: IForgotPasswordPresenter? { get set }
}

final class ForgotPasswordViewController: BaseViewController, IForgotPasswordView {
    
    var presenter: IForgotPasswordPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "") { [weak presenter] in
        presenter?.backTapped()
    }
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
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
        label.font = .medium12
        label.text = "Enter your email for the verification process, we will send code to your email"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emailFieldView: SMTextFieldView = {
        let fieldView = SMTextFieldView()
        fieldView.setPlaceholderText(text: "id or email")
        fieldView.setLeftImage(image: Asset.icEnvelope.image)
        fieldView.delegate = presenter as? SMTextFieldViewDelegate
        fieldView.layer.cornerRadius = 15
        return fieldView
    }()
    
    private lazy var continueButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .medium16
        button.tintColor = .white
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
//        button.isEnabled = false
//        button.alpha = 0.5
        return button
    }()
    
    override func loadView() {
        super.loadView()
        self.view = AuthView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubviews([navigationBar, labelsStackView, emailFieldView, continueButton])
        labelsStackView.addArrangedSubviews([forgotPasswordLabel, descriptionLabel])
    }
    
    private func setupConstraints() {
        labelsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-124)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        emailFieldView.snp.makeConstraints { make in
            make.top.equalTo(labelsStackView.snp.bottom).offset(58)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(54)
        }
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(emailFieldView.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(54)
        }
    }
    
    @objc func continueTapped() {
        presenter?.continueTapped()
    }
}
