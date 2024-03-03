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
}
