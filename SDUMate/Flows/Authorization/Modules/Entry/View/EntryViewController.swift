//
//  EntryViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import UIKit

protocol IEntryView: Presentable {
    var presenter: IEntryPresenter? { get set }
}

final class EntryViewController: BaseViewController, IEntryView {
    var presenter: IEntryPresenter?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bold48
        label.text = "SDUMate"
        label.textColor = .white
        return label
    }()
    
    private lazy var signInButton: GradientButton = {
        let button = GradientButton()
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = .medium16
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var createAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium16
        label.text = "Create account"
        label.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(createAccountTapped))
        label.addGestureRecognizer(tapRecognizer)
        return label
    }()
    
    override func loadView() {
        super.loadView()
        self.view = AuthView()
    }
    
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        setupTitleLabel()
    }
    
    private func setupViews() {
        view.addSubviews([titleLabel, signInButton, createAccountLabel])
    }
    
    private func setupConstraints() {
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(131)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(52)
        }
        
        createAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-((view.frame.height - titleLabel.font.lineHeight) * 0.06))
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func signInTapped() {
        signInButton.animatePress()
        presenter?.signInTapped()
    }
    
    @objc func createAccountTapped() {
        presenter?.createAccountTapped()
    }
}
