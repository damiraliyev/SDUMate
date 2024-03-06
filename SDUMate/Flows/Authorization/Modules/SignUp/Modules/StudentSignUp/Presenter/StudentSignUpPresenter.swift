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
}

final class StudentSignUpPresenter: IStudentSignUpPresenter {
    
    weak var view: IStudentSignUpView?
    private weak var coordinator: IAuthCoordinator?
    
    private var email: String = ""
    private var password: String = ""
    private var confirmedPassword: String = ""
    
    init(view: IStudentSignUpView, coordinator: IAuthCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func loginTapped() {
        coordinator?.showSignInView()
    }
    
    private func verifyInfo() {
        guard isOnlyDigits(text: email), password.count > 5, password == confirmedPassword else {
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
            email = text
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
