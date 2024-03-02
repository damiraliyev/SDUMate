//
//  AboutSetupViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import UIKit

protocol IAboutSetupView: Presentable {
    var presenter: IAboutSetupPresenter? { get set }
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
    
    let nameFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Name")
        view.set(placeholderText: "Your name")
        return view
    }()
    
    let surnameFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Surname")
        view.set(placeholderText: "Your surname")
        return view
    }()
    
    let nicknameFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Nickname")
        view.set(placeholderText: "Your nickname")
        return view
    }()
    
    let telegramFormFieldView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Telegram")
        view.set(placeholderText: "Telegram tag (Optional)")
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
        view.addSubviews([navigationBar, fieldsStackView])
        fieldsStackView.addArrangedSubviews([nameFormFieldView, surnameFormFieldView, nicknameFormFieldView, telegramFormFieldView])
    }
    
    private func setupConstraints() {
        fieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
