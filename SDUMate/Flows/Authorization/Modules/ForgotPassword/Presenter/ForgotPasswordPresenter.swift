//
//  ForgotPasswordPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 18.03.2024.
//

import Foundation

protocol IForgotPasswordPresenter: AnyObject {
    func backTapped()
    func continueTapped()
}

final class ForgotPasswordPresenter: IForgotPasswordPresenter {
    
    weak var view: IForgotPasswordView?
    private weak var coordinator: IAuthCoordinator?
    private let authManager: AuthManager
    
    private var email = ""
    
    init(view: IForgotPasswordView, coordinator: IAuthCoordinator, authManager: AuthManager) {
        self.view = view
        self.coordinator = coordinator
        self.authManager = authManager
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func continueTapped() {
        let fullEmail = email + "@stu.sdu.edu.kz"
        authManager.resetPassword(email: fullEmail) { [weak self] error in
            guard error == nil else {
                self?.coordinator?.showErrorAlert(errorMessage: error?.localizedDescription ?? "Something went wrong. Try again please")
                return
            }
            self?.coordinator?.showVerificationSentView()
        }
        
    }
}

extension ForgotPasswordPresenter: SMTextFieldViewDelegate {
    func textFieldDidChange(text: String, tag: Int) {
        email = text
    }
}
