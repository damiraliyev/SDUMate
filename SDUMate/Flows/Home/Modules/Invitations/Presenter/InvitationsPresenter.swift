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
    func getInvitation(for indexPath: IndexPath) -> Invitation?
    func getSectionsCount() -> Int
    func getItemsCount(for section: Int) -> Int
    func getSectionTitle(for section: Int) -> String?
}

final class InvitationsPresenter: IInvitationsPresenter {
    private var invitations: [Invitation] = []
    var invitationsDataSource: [Invitation] = []
    
    var dateSection: [Int: String] = [:]
    var invitationsDict: [String: [Invitation]] = [:]
    var invitationsDataSourceDict: [String: [Invitation]] = [:]
    
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
            self.setupData(with: invitations)
            self.invitations = invitations.sorted(by: {$0.createdDate.toDate() > $01.createdDate.toDate() })
            self.invitationsDataSource = invitations
            self.filterByType()
        } .catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
    
    private func setupData(with invitations: [Invitation]) {
        for invitation in invitations {
            let date = invitation.createdDate.toDate().toString(format: "dd.MM.yyyy")
            if let inv = invitationsDict[date] {
                invitationsDict[date]?.append(invitation)
            } else {
                invitationsDict[date] = [invitation]
            }
        }
    }
    
    private func filterByType() {
        guard let id = AuthManager.shared.getAuthUser()?.uid else { return }
        switch type {
        case .received:
            for (key, _) in invitationsDict {
                invitationsDataSourceDict[key] = invitationsDict[key]!.filter({ $0.announcerId == id }).sorted(by: {$0.createdDate.toDate() > $1.createdDate.toDate()})
            }
        case .sent:
            for (key, _) in invitationsDict {
                invitationsDataSourceDict[key] = invitationsDict[key]!.filter({ $0.respondentId == id }).sorted(by: {$0.createdDate.toDate() > $1.createdDate.toDate()})
            }
        }
        for (key, _) in invitationsDataSourceDict {
            if invitationsDataSourceDict[key]!.isEmpty {
                invitationsDataSourceDict.removeValue(forKey: key)
            }
        }
        
        dateSection.removeAll()
        var dates: [String] = []
        
        for (key, _) in invitationsDataSourceDict {
            dates.append(key)
        }
        dates = dates.sorted(by: { $0 > $1 })
        for i in 0..<dates.count {
            dateSection[i] = dates[i]
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
    
    func getInvitation(for indexPath: IndexPath) -> Invitation? {
        guard let invitation = invitationsDataSourceDict[dateSection[indexPath.section] ?? ""]?[safe: indexPath.row] else { return nil }
        return invitation
    }
    
    func getSectionsCount() -> Int {
        return dateSection.count
    }
    
    func getItemsCount(for section: Int) -> Int {
        let date = dateSection[section] ?? ""
        guard let invitations = invitationsDataSourceDict[date] else { return 0 }
        return invitations.count
    }
    
    func getSectionTitle(for section: Int) -> String? {
        return dateSection[section]
    }
}
