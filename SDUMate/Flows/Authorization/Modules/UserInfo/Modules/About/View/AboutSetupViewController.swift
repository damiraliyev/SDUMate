//
//  AboutSetupViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import UIKit

protocol IAboutSetupView: Presentable {
    var presenter: IAboutSetupPresenter? { get set }
    
    func enableButton()
    func disableButton()
}

final class AboutSetupViewController: BaseViewController, IAboutSetupView {
    
    var presenter: IAboutSetupPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "About") { [weak presenter] in
        presenter?.backTapped()
    }
    
    private let fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let nameFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Name")
        view.set(placeholderText: "Your name")
        view.tag = SMTextFieldTag.name.rawValue
        return view
    }()
    
    private let surnameFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Surname")
        view.set(placeholderText: "Your surname")
        view.tag = SMTextFieldTag.surname.rawValue
        return view
    }()
    
    private let nicknameFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Nickname")
        view.set(placeholderText: "Your nickname")
        view.tag = SMTextFieldTag.nickname.rawValue
        return view
    }()
    
    private let telegramFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Telegram")
        view.set(placeholderText: "Telegram tag (Optional)")
        view.tag = SMTextFieldTag.telegramTag.rawValue
        return view
    }()
    
    private lazy var continueButton: GradientButton = {
        let button = GradientButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .medium16
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
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
        setupTextFieldsDelegate()
    }
    
    private func setupViews() {
        view.addSubviews([navigationBar, fieldsStackView, continueButton])
        fieldsStackView.addArrangedSubviews([nameFormFieldView, surnameFormFieldView, nicknameFormFieldView, telegramFormFieldView])
    }
    
    private func setupConstraints() {
        fieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-48)
            make.height.equalTo(52)
        }
    }
    
    private func setupTextFieldsDelegate() {
        guard let presenter = presenter as? SMTextFieldViewDelegate else { return }
        [nameFormFieldView, surnameFormFieldView, nicknameFormFieldView, telegramFormFieldView].forEach {
            $0.addTextFieldDelegate(handler: presenter)
        }
    }
    
    @objc func continueTapped() {
        presenter?.continueTapped()
    }
    
    func enableButton() {
        continueButton.isEnabled = true
        continueButton.alpha = 1
    }
    
    func disableButton() {
        continueButton.isEnabled = false
        continueButton.alpha = 0.5
    }
}
