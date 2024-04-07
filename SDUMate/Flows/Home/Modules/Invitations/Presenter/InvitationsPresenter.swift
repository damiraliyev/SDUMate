//
//  InvitationsPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 22.03.2024.
//

import Foundation
import PromiseKit

protocol IInvitationsPresenter: AnyObject {
    var invitationsDataSource: [Invitation] { get }
    
    func backTapped()
    func viewDidLoad()
    func typeChanged(to type: InvitationType)
}

final class InvitationsPresenter: IInvitationsPresenter {
    private var invitations: [Invitation] = []
    var invitationsDataSource: [Invitation] = []
    
    weak var view: IInvitationsView?
    private weak var coordinator: IHomeCoordinator?
    
    private var type: InvitationType = .received
    
    init(view: IInvitationsView, coordinator: IHomeCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func viewDidLoad() {
        fetchInvitations()
    }
    
    private func fetchInvitations() {
        firstly {
            InvitationManager.shared.fetchCompleteInvitations(userId: AuthManager.shared.getAuthUser()?.uid ?? "")
        } .done { invitations in
            self.invitations = invitations.sorted(by: {$0.createdDate.toDate() > $01.createdDate.toDate() })
            self.invitationsDataSource = invitations
            self.filterByType()
        } .catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
    
    private func filterByType() {
        guard let id = AuthManager.shared.getAuthUser()?.uid else { return }
        switch type {
        case .received:
            invitationsDataSource = invitations.filter({ $0.announcerId == id }).sorted(by: {$0.createdDate.toDate() > $01.createdDate.toDate()})
        case .sent:
            invitationsDataSource = invitations.filter({ $0.respondentId == id }).sorted(by: {$0.createdDate.toDate() > $01.createdDate.toDate()})
        }
        view?.reload()
    }
    
    func typeChanged(to type: InvitationType) {
        self.type = type
        filterByType()
    }
}

extension InvitationsPresenter: InvitationCellDelegate {
    func acceptTapped(invitationId: String) {
        InvitationManager.shared.acceptInvitation(withId: invitationId).done { _ in
            print("STATUS CHANGED SUCCESSFULLY")
        }.catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
    
    func rejectedTapped(invitationId: String) {
        InvitationManager.shared.rejectInvitation(withId: invitationId).done { _ in
            print("STATUS CHANGED SUCCESSFULLY")
        }.catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
}
