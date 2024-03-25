//
//  InvitationsPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 22.03.2024.
//

import Foundation
import PromiseKit

protocol IInvitationsPresenter: AnyObject {
    func backTapped()
    func viewDidLoad()
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
    
    func viewDidLoad() {
        firstly {
            InvitationManager.shared.fetchCompleteInvitations(userId: AuthManager.shared.getAuthUser()?.uid ?? "")
        } .done { invitations in
            print("INVITATIONS", invitations)
        } .catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
        
    }
}
