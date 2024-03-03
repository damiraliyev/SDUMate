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
        view.addSubviews([labelsStackView])
        labelsStackView.addArrangedSubviews([registerLabel, createAccountLabel])
    }
    
    private func setupConstraints() {
        
    }
}
