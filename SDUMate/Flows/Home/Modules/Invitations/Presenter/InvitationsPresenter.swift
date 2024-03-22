//
//  InvitationsPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 22.03.2024.
//

import Foundation

protocol IInvitationsPresenter: AnyObject {
    func backTapped()
}

final class InvitationsPresenter: IInvitationsPresenter {
    
    weak var view: IInvitationsView?
    private weak var coordinator: IHomeCoordinator?
    
    init(view: IInvitationsView, coordinator: IHomeCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
}
