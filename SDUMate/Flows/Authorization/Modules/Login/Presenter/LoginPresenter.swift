//
//  LoginPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 25.02.2024.
//

import Foundation

protocol ILoginPresenter: AnyObject {
    func loginTapped()
    func backTapped()
    func signUpTapped()
}

final class LoginPresenter: ILoginPresenter {
    
    weak var view: ILoginView?
    private let coordinator: IAuthCoordinator
    
    init(coordinator: IAuthCoordinator, view: ILoginView) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func loginTapped() {
        let isFullyAuthorizedBefore = false
        isFullyAuthorizedBefore ? coordinator.showHome() : coordinator.showUserInfoSetup()
    }
    
    func backTapped() {
        coordinator.onBackTapped(completion: nil)
    }
    
    func signUpTapped() {
        coordinator.showAccountChoiceView()
    }
}
