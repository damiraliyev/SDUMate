//
//  ProfilePresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 24.03.2024.
//

import Foundation

protocol IProfilePresenter: AnyObject {
    func backTapped()
}

final class ProfilePresenter: IProfilePresenter {
    
    weak var view: IProfileView?
    private weak var coordinator: IProfileCoordinator?
    
    init(view: IProfileView, coordinator: IProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.backTapped { [weak self] in
            self?.coordinator?.onFlowDidFinish?()
        }
    }
}
