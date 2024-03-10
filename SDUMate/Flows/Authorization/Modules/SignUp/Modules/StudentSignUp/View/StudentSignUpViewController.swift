//
//  StudentSignUpViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import UIKit

protocol IStudentSignUpView: Presentable {
    var presenter: IStudentSignUpPresenter? { get set }
    
    func enableButton()
    func disableButton()
}

enum SMTextFieldTag: Int {
    case emailTag = 1
    case passwordTag = 2
    case confirmPassowrdTag = 3
    case name = 4
    case surname = 5
    case nickname = 6
    case telegramTag = 7
}

final class StudentSignUpViewController: BaseViewController {
    
    var presenter: IStudentSignUpPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "") { [weak presenter] in
        presenter?.backTapped()
    }
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium36
        label.text = "Register"
        return label
    }()
    
    private let createAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lavender
        label.font = .medium16
        label.text = "Create your account"
        return label
    }()
    
    private let fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let emailFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Student id")
        view.set(placeholderText: "Enter your id")
        view.set(leftImage: Asset.icEnvelope.image)
        view.tag = SMTextFieldTag.emailTag.rawValue
        return view
    }()
    
    private let passwordFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Password")
        view.set(placeholderText: "Enter password")
        view.set(leftImage: Asset.lock.image)
        view.makeTextSecure()
        view.set(rightImage: Asset.eyeOpen.image)
        view.tag = SMTextFieldTag.passwordTag.rawValue
        return view
    }()
    
    private let confirmPasswordFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Confirm password")
        view.set(placeholderText: "Re-enter password")
        view.set(leftImage: Asset.lock.image)
        view.makeTextSecure()
        view.set(rightImage: Asset.eyeOpen.image)
        view.tag = SMTextFieldTag.confirmPassowrdTag.rawValue
        return view
    }()
    
    private lazy var verifyButton: GradientButton = {
        let button = GradientButton()
        button.setTitle("Verify email", for: .normal)
        button.titleLabel?.font = .medium16
        button.addTarget(self, action: #selector(verifyTapped), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        label.addGestureRecognizer(tapRecognizer)
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
    
    private func setupViews() {
        view.addSubviews([navigationBar, labelsStackView, fieldsStackView, verifyButton, loginLabel])
        labelsStackView.addArrangedSubviews([registerLabel, createAccountLabel])
        fieldsStackView.addArrangedSubviews([emailFormFieldView, passwordFormFieldView, confirmPasswordFormFieldView])
        setupLoginAttributedText()
        setupTextFieldsDelegate()
    }
    
    private func setupConstraints() {
        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        fieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(labelsStackView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        verifyButton.snp.makeConstraints { make in
            make.top.equalTo(fieldsStackView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(verifyButton.snp.bottom).offset(21)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupLoginAttributedText() {
        let defaultTextAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.regular14, .foregroundColor: UIColor.lavender]
        let signUpAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.bold14, .foregroundColor: UIColor.orange]
        let rootString = NSMutableAttributedString(string: "Already have an account? ", attributes: defaultTextAttributes)
        let signUpString = NSAttributedString(string: "Log in", attributes: signUpAttributes)
        rootString.append(signUpString)
        loginLabel.attributedText = rootString
    }
    
    private func setupTextFieldsDelegate() {
        guard let presenter = presenter as? SMTextFieldViewDelegate else { return }
        emailFormFieldView.addTextFieldDelegate(handler: presenter)
        passwordFormFieldView.addTextFieldDelegate(handler: presenter)
        confirmPasswordFormFieldView.addTextFieldDelegate(handler: presenter)
    }
    
    @objc func verifyTapped() {
        verifyButton.animatePress()
        presenter?.verifyTapped()
    }
    
    @objc func loginTapped() {
        presenter?.loginTapped()
    }
}

extension StudentSignUpViewController: IStudentSignUpView {
    func enableButton() {
        verifyButton.isEnabled = true
        verifyButton.alpha = 1
    }
    
    func disableButton() {
        verifyButton.isEnabled = false
        verifyButton.alpha = 0.5
    }
}
