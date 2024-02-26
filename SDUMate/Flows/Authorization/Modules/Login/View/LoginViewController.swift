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
        label.textColor = Asset.lavender.color
        label.font = .medium16
        label.text = "Login to your account"
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
        view.addSubviews([welcomeLabel, loginToAccountLabel])
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
    }
}
