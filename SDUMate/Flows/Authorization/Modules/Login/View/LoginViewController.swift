//
//  LoginViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 25.02.2024.
//

import UIKit

protocol ILoginView: Presentable {
    var presenter: ILoginPresenter? { get set }
}

final class LoginViewController: UIViewController, ILoginView {
    
    var presenter: ILoginPresenter?
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium36
        label.text = "Welcome Back"
        return label
    }()
    
    private let loginToAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lavender
        label.font = .medium16
        label.text = "Login to your account"
        return label
    }()
    
    private let fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let emailFieldView: SMTextFieldView = {
        let fieldView = SMTextFieldView()
        fieldView.setLeftImage(image: Asset.person.image)
        fieldView.setPlaceholderText(text: "id or email")
        return fieldView
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
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        setupWelcomeLabelConstraints()
    }
    
    private func setupViews() {
        view.addSubviews([welcomeLabel, loginToAccountLabel, fieldsStackView])
        fieldsStackView.addArrangedSubviews([emailFieldView])
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupWelcomeLabelConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.frame.height * 0.305)
            make.centerX.equalToSuperview()
        }
        loginToAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        fieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(loginToAccountLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        emailFieldView.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
    }
}
