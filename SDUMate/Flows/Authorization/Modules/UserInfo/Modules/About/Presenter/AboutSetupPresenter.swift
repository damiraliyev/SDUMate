//
//  AboutSetupPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import Foundation

protocol IAboutSetupPresenter: AnyObject {
    func backTapped()
    func continueTapped()
}

final class AboutSetupPresenter: IAboutSetupPresenter {
    
    weak var view: IAboutSetupView?
    private weak var coordinator:  IUserInfoSetupCoordinator?
    
    init(view: IAboutSetupView, coordinator: IUserInfoSetupCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped() {
            self.coordinator?.onFlowDidFinish?()
        }
    }
    
    func continueTapped() {
        coordinator?.showStudySetupView()
    }
}
