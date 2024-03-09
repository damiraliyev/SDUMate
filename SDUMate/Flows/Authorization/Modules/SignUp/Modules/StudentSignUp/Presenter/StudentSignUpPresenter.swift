//
//  StudentSignUpPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import Foundation

protocol IStudentSignUpPresenter: AnyObject {
    func backTapped()
    func loginTapped()
    func verifyTapped()
}

final class StudentSignUpPresenter: IStudentSignUpPresenter {
    
    weak var view: IStudentSignUpView?
    private weak var coordinator: IAuthCoordinator?
    private let authManager: AuthManager
    
    private var id: String = ""
    private var password: String = ""
    private var confirmedPassword: String = ""
    
    init(view: IStudentSignUpView, coordinator: IAuthCoordinator, authManager: AuthManager) {
        self.view = view
        self.coordinator = coordinator
        self.authManager = authManager
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func verifyTapped() {
        let email = id + "@stu.sdu.edu.kz"
        authManager.createUser(email: email, password: password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                authManager.sendVerificationMail { error in
                    guard error == nil else {
                        self.coordinator?.showErrorAlert(errorMessage: error?.localizedDescription ?? "Something went wrong, try again please.")
                        return
                    }
                    self.coordinator?.showVerificationSentView()
                }
            case .failure(let error):
                coordinator?.showErrorAlert(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func loginTapped() {
        coordinator?.onBackTapped(completion: {
            self.coordinator?.showSignInView()
        })
    }
    
    private func verifyInfo() {
        guard isOnlyDigits(text: id), password.count > 5, password == confirmedPassword else {
            view?.disableButton()
            return
        }
        view?.enableButton()
    }
    
    private func isOnlyDigits(text: String) -> Bool {
        let regex = "^\\d+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
}

extension StudentSignUpPresenter: SMTextFieldViewDelegate {
    func textFieldDidChange(text: String, tag: Int) {
        let type = SMTextFieldTag(rawValue: tag)
        switch type {
        case .emailTag:
            id = text
        case .passwordTag:
            password = text
        case .confirmPassowrdTag:
            confirmedPassword = text
        case .none:
            break
        }
        verifyInfo()
    }
}
