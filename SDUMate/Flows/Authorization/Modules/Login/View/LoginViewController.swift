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
    }
    
    private func setupConstraints() {
        
    }
}
