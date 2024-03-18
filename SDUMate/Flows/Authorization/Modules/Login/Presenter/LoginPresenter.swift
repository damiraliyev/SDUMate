//
//  LoginPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 25.02.2024.
//

import Foundation
import FirebaseAuth

protocol ILoginPresenter: AnyObject {
    func loginTapped()
    func backTapped()
    func signUpTapped()
    func forgotPasswordTapped()
}

final class LoginPresenter: ILoginPresenter {
    
    weak var view: ILoginView?
    private let coordinator: IAuthCoordinator
    private let authManager: AuthManager
    var email: String = ""
    var password: String = ""
    
    init(coordinator: IAuthCoordinator, view: ILoginView, authManager: AuthManager) {
        self.view = view
        self.coordinator = coordinator
        self.authManager = authManager
    }
    
    func loginTapped() {
        let fullEmail = email + "@stu.sdu.edu.kz"
        authManager.login(email: fullEmail, password: password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                fetchUser(authUser: authManager.getAuthUser())
            case .failure(let error):
                handle(error: error)
            }
        }
    }
    
    func backTapped() {
        coordinator.onBackTapped(completion: nil)
    }
    
    func signUpTapped() {
        coordinator.showAccountChoiceView()
    }
    
    func forgotPasswordTapped() {
        coordinator.showForgotPasswordView()
    }
    
    private func fetchUser(authUser: User?) {
        guard let user = authUser else { return }
        UserManager.shared.getUser(userId: user.uid) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let dbUser):
                let isFullyAuthorizedBefore = false
                isFullyAuthorizedBefore ? coordinator.showHome() : coordinator.showUserInfoSetup()
            case .failure(let error):
                if let error = error as? SMError {
                    coordinator.showErrorAlert(errorMessage: error.localizedDescription)
                } else {
                    coordinator.showErrorAlert(errorMessage: error.localizedDescription)
                }
            }
        }
    }
    
    private func handle(error: Error) {
        if let error = error as? SMError {
            switch error {
            case .needEmailToBeVerified:
                let input = AlertInput(title: "Verify email", message: error.localizedDescription, cancelTitle: "Ok", actionTitle: "Resend verification mail") { [weak self] in
                    self?.sendVerificationMail()
                }
                self.coordinator.showAlert(input: input)
            default:
                coordinator.showErrorAlert(errorMessage: error.localizedDescription)
            }
        } else {
            coordinator.showErrorAlert(errorMessage: error.localizedDescription)
        }
    }
    
    private func sendVerificationMail() {
        authManager.sendVerificationMail { [weak self] error in
            guard let self else { return }
            guard error == nil else {
                coordinator.showErrorAlert(errorMessage: error?.localizedDescription ?? "")
                return
            }
            let input = AlertInput(title: "Sent", message: "Verification mail were resent to your email", actionTitle: "Ok")
            coordinator.showAlertWithoutCancel(input: input, style: .default)
        }
    }
}

extension LoginPresenter: SMTextFieldViewDelegate {
    func textFieldDidChange(text: String, tag: Int) {
        let fieldType = SMTextFieldTag(rawValue: tag)
        switch fieldType {
        case .emailTag:
            email = text
        case .passwordTag:
            password = text
        default:
            break
        }
    }
}
