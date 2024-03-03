//
//  StudentSignUpViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import UIKit

protocol IStudentSignUpView: Presentable {
    var presenter: IStudentSignUpPresenter? { get set }
}

final class StudentSignUpViewController: BaseViewController, IStudentSignUpView {
    
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
        label.text = "Create you account"
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
        return view
    }()
    
    private let passwordFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Password")
        view.set(placeholderText: "Enter password")
        view.set(leftImage: Asset.lock.image)
        view.makeTextSecure()
        view.set(rightImage: Asset.eyeOpen.image)
        return view
    }()
    
    private let confirmPasswordFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Confirm password")
        view.set(placeholderText: "Re-enter password")
        view.set(leftImage: Asset.lock.image)
        view.makeTextSecure()
        view.set(rightImage: Asset.eyeOpen.image)
        return view
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
        view.addSubviews([navigationBar, labelsStackView, fieldsStackView])
        labelsStackView.addArrangedSubviews([registerLabel, createAccountLabel])
        fieldsStackView.addArrangedSubviews([emailFormFieldView, passwordFormFieldView, confirmPasswordFormFieldView])
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
    }
}
