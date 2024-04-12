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
            self.sessions = sessions
            self.dataSource = sessions
            self.view?.reload()
        } .catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
    
    func typeTapped(type: SessionSelection) {
        switch type {
        case .all:
            dataSource = sessions
        case .offer:
            dataSource = sessions.filter { $0.announcement?.type == .offer }
        case .request:
            dataSource = sessions.filter { $0.announcement?.type == .request }
        case .collaborate:
            dataSource = sessions.filter { $0.announcement?.type == .collaborate }
        }
        configureEmptyStateIfNeeded()
        view?.reload()
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
        print("DEINITED PRESENTEr")
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
        var status: SessionStatus
        if id == session.announcerId && session.status == .active {
            status = .announcerFinished
        } else if id == session.respondentId && session.status == .active {
            status = .responderFinished
        } else {
            status = .finished
        }
        let endAction = UIAlertAction(title: "End session", style: .destructive) { [weak self] _ in
            SessionsManager.shared.endSession(sessionId: session.id, newStatus: status).done { _ in
                print("NEED TO SHOW FEEDBACK")
            }.catch { error in
                self?.coordinator?.showErrorAlert(error: error.localizedDescription)
            }
        }
        let cancelAction = UIAlertAction(title: CoreL10n.cancel, style: .cancel, handler: nil)
        coordinator?.showEndSessionAlert(endAction: endAction, cancelAction: cancelAction)
    }
}
