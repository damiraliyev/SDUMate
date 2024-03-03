//
//  AccountChoicePresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import UIKit

protocol IAccountChoicePresenter: AnyObject {
    func studentTapped()
    func alumniTapped()
}

final class AccountChoicePresenter: IAccountChoicePresenter {
    
    weak var view: IAccountChoiceView?
    private weak var coordinator: IAuthCoordinator?
    
    init(view: IAccountChoiceView, coordinator: IAuthCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func studentTapped() {
        coordinator?.showStudentSignUpView()
    }
    
    func alumniTapped() {
        coordinator?.showAlumniSignUpView()
    }
}
