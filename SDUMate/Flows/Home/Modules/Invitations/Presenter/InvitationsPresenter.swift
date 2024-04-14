//
//  InvitationsPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 22.03.2024.
//

import Foundation
import PromiseKit
import UIKit

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
            invitationsDataSource = invitations.filter({ $0.announcerId == id }).sorted(by: {$0.createdDate.toDate() > $1.createdDate.toDate()})
        case .sent:
            invitationsDataSource = invitations.filter({ $0.respondentId == id }).sorted(by: {$0.createdDate.toDate() > $1.createdDate.toDate()})
        }
        view?.reload()
    }
    
    func typeChanged(to type: InvitationType) {
        self.type = type
        filterByType()
    }
}

extension InvitationsPresenter: InvitationCellDelegate {
    func profileTapped(responder: DBUser, announcementDescription: String) {
        self.coordinator?.showResponderInfo(responder: responder, announcementDescription: announcementDescription)
    }
    
    func acceptTapped(invitationId: String) {
        firstly {
            InvitationManager.shared.acceptInvitation(withId: invitationId)
        }.then { _ -> Promise<Void> in
            guard let invitation = self.invitations.filter({ $0.id == invitationId }).first else {
                return Promise.value(())
            }
            return InvitationManager.shared.createSession(invitation: invitation)
        } .then({ _ -> Promise<Void> in
            guard let invitation = self.invitations.filter({ $0.id == invitationId }).first else {
                return Promise.value(())
            }
            return InvitationManager.shared.establishSession(announcementId: invitation.announcementId)
        })
        .catch { error in
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
    
    func withdrawTapped(invitationId: String) {
        // present action sheet
        let endAction = UIAlertAction(title: "End session", style: .destructive) { [weak self] _ in
            self?.withdrawInvitation(invitationId: invitationId)
        }
        let cancelAction = UIAlertAction(title: CoreL10n.cancel, style: .cancel, handler: nil)
        coordinator?.showWithdrawConfirmationSheet(endAction: endAction, cancelAction: cancelAction)
    }
    
    private func withdrawInvitation(invitationId: String) {
        InvitationManager.shared.withdrawInvitation(invitationId: invitationId).done { () in
            print("Invitation withdrawn")
        }.catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
}
