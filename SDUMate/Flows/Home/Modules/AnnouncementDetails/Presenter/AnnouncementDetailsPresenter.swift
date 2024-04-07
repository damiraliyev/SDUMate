//
//  AnnouncementDetailsPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol IAnnouncementDetailsPresenter: AnyObject {
    var onBackTapped: Completion? { get set }
    
    func sendTapped(_ announcement: Announcement)
}

final class AnnouncementDetailsPresenter: IAnnouncementDetailsPresenter {
    weak var view: IAnnouncementDetailsView?
    private let coordinator: IHomeCoordinator?
    private let announcementDetailsManager: AnnouncementDetailsManager
    
    var onBackTapped: Completion?
    
    init(view: IAnnouncementDetailsView, coordinator: IHomeCoordinator, manager: AnnouncementDetailsManager) {
        self.view = view
        self.coordinator = coordinator
        announcementDetailsManager = manager
    }
    
    func sendTapped(_ announcement: Announcement) {
        let invitation = Invitation(id: "", createdDate: Date().toUTCString(), announcerId: announcement.announcerId, respondentId: AuthManager.shared.getAuthUser()?.uid ?? "", announcementId: announcement.id, status: .pending)
        announcementDetailsManager.sendInvitation(invitation: invitation).done { _ in
            print("SENT SUCCESFULLY")
        }.catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
}
