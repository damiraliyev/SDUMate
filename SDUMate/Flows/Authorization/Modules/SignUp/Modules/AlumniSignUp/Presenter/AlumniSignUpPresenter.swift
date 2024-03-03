//
//  AlumniSignUpPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import Foundation

protocol IAlumniSignUpPresenter: AnyObject {
    func backTapped()
    func verifyTapped()
    func loginTapped()
}

final class AlumniSignUpPresenter: IAlumniSignUpPresenter {
    
    weak var view: IAlumniSignUpView?
    private weak var coordinator: IAuthCoordinator?
    
    init(view: IAlumniSignUpView, coordinator: IAuthCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func verifyTapped() {
        
    }
    
    func loginTapped() {
        coordinator?.showSignInView()
    }
}
