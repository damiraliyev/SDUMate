//
//  SessionsPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

protocol ISessionsPresenter: AnyObject {
    var dataSource: [Session] { get }
    
    func viewDidLoad()
    func typeTapped(type: SessionSelection)
    func didSelectItem(at indexPath: IndexPath)
}

final class SessionsPresenter: ISessionsPresenter {
    
    weak var view: ISessionsView?
    private weak var coordinator: ISessionsCoordinator?
    private let id = AuthManager.shared.getAuthUser()?.uid ?? ""
    lazy var sessions: [Session] = []
    
    lazy var dataSource: [Session] = sessions
    
    init(view: ISessionsView, coordinator: ISessionsCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        SessionsManager.shared.fetchCompleteSessions().done { sessions in
            guard let id = AuthManager.shared.getAuthUser()?.uid else { return }
            self.sessions = sessions.filter { (session: Session) -> Bool in
                if session.status == .active {
                    return true
                } else if id == session.respondentId && session.status == .announcerFinished {
                    return true
                } else if id == session.announcerId && session.status == .responderFinished {
                    return true
                }
                return false
            }
            self.dataSource = self.sessions
            self.view?.reload()
        } .catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
            self.view?.reload()
        }
    }
    
    func typeTapped(type: SessionSelection) {
        guard let id = AuthManager.shared.getAuthUser()?.uid else { return }
        switch type {
        case .all:
            dataSource = sessions
        case .offer:
            filterOffers()
        case .request:
            filterRequests()
        case .collaborate:
            filterCollaborations()
        }
        configureEmptyStateIfNeeded()
        view?.reload()
    }
    
    private func filterOffers() {
        dataSource = sessions.filter { session in
            let firstCase = session.announcement?.type == .offer && session.announcerId == id
            let secondCase = session.announcement?.type == .request && session.respondentId == id
            return firstCase || secondCase
        }
    }
    
    private func filterRequests() {
        dataSource = sessions.filter {
            let firstCase = $0.announcement?.type == .offer && $0.respondentId == id
            let secondCase = $0.announcement?.type == .request && $0.announcerId == id
            return firstCase || secondCase
        }
    }
    
    private func filterCollaborations() {
        dataSource = sessions.filter { $0.announcement?.type == .collaborate }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let session = dataSource[indexPath.row]
        guard let announcement = session.announcement else { return }
//        coordinator?.showAnnouncementDetailsView(with: announcement)
    }
    
    private func configureEmptyStateIfNeeded() {
        if dataSource.isEmpty {
            view?.showEmptyState()
        } else {
            view?.hideEmptyState()
        }
    }
    
    deinit {
        print("DEINITED PRESENTER")
    }
}

extension SessionsPresenter: SessionCellDelegate {
    func contactTapped(otherSide: DBUser, announcementDescription: String) {
        coordinator?.showOtherSideProfile(responder: otherSide, announcementDescription: announcementDescription)
    }
    
    func moreTapped(session: Session) {
        guard let announcement = session.announcement,
              let announcer = session.announcer,
              let respondent = session.respondent else {
            return
        }
        coordinator?.showAnnouncementDetailsView(with: announcement, announcer: announcer, respondent: respondent)
    }
    
    func threeDotsTapped(session: Session) {
        guard let id = AuthManager.shared.getAuthUser()?.uid else { return }
        var otherSide: DBUser?
        if id == session.announcerId {
            otherSide = session.respondent
        } else if id == session.respondentId {
            otherSide = session.announcer
        }
        let endAction = UIAlertAction(title: "End session", style: .destructive) { [weak self] _ in
            guard let otherSide = otherSide else {
                return
            }
            self?.coordinator?.showProvideFeedback(otherSide: otherSide, session: session)
        }
        let cancelAction = UIAlertAction(title: CoreL10n.cancel, style: .cancel, handler: nil)
        coordinator?.showEndSessionAlert(endAction: endAction, cancelAction: cancelAction)
    }
}
