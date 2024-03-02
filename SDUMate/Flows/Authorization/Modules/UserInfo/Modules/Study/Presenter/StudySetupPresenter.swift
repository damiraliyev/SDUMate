//
//  StudySetupPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import Foundation

protocol IStudySetupPresenter: AnyObject {
    func backTapped()
}

final class StudySetupPresenter: IStudySetupPresenter {
    
    weak var view: IStudySetupView?
    private weak var coordinator: IUserInfoSetupCoordinator?
    
    init(view: IStudySetupView, coordinator: IUserInfoSetupCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
}
