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
    
    private lazy var navigationBar = SMNavigationBar(title: "", tapCallback: nil)
    
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
    
    private let passwordTextField: SMTextFieldView = {
        let textField = SMTextFieldView()
        textField.setLeftImage(image: Asset.lock.image)
        textField.makeTextSecure()
        textField.addRightImageView(image: Asset.eyeOpen.image)
        textField.setPlaceholderText(text: "Password")
        return textField
    }()
    
    private lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = .regular14
        label.textColor = .lavender
        label.text = "Forgot password"
        return label
    }()
    
    private lazy var loginButton: GradientButton = {
        let button = GradientButton()
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = .medium16
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.font = .regular14
        label.textColor = .lavender
        label.text = "Do not have an account? Sign up"
        return label
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
        view.addSubviews([navigationBar, welcomeLabel, loginToAccountLabel, fieldsStackView, forgotPasswordLabel,
                          loginButton, signUpLabel])
        fieldsStackView.addArrangedSubviews([emailFieldView, passwordTextField])
        setupSignUpAttributedText()
    }
    
    private func setupConstraints() {
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
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        forgotPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(fieldsStackView.snp.bottom).offset(10)
            make.trailing.equalTo(fieldsStackView)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupWelcomeLabelConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.frame.height * 0.305)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupSignUpAttributedText() {
        let defaultTextAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.regular14, .foregroundColor: UIColor.lavender]
        let signUpAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.bold14, .foregroundColor: UIColor.lavender, .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.lavender]
        let rootString = NSMutableAttributedString(string: "Do not have an account? ", attributes: defaultTextAttributes)
        let signUpString = NSAttributedString(string: "Sign Up", attributes: signUpAttributes)
        rootString.append(signUpString)
        signUpLabel.attributedText = rootString
    }
    
    @objc func loginTapped() {
        presenter?.loginTapped()
    }
}
