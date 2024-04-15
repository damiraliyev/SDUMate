//
//  UserInfoPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.04.2024.
//

import Foundation

protocol IAnnouncementResponderInfoCoordinator: IBaseCoordinator {
    func onBackTapped(completion: Completion?)
    func showFeedbacks(userId: String)
}

protocol IAnnouncementResponderInfoPresenter: AnyObject {
    func backTapped()
    func viewDidLoad()
    func seeAllTapped()
}

final class AnnouncementResponderInfoPresenter: IAnnouncementResponderInfoPresenter {
    
    weak var view: IAnnouncementResponderInfoView?
    private weak var coordinator: IAnnouncementResponderInfoCoordinator?
    private let responder: DBUser
    private let announcementDescription: String
    
    init(responder: DBUser, announcementDescription: String, view: IAnnouncementResponderInfoView, coordinator: IAnnouncementResponderInfoCoordinator) {
        self.responder = responder
        self.announcementDescription = announcementDescription
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func viewDidLoad() {
        UserManager.shared.fetchFeedbacks(userId: responder.userId).done { [weak self] feedbacks in
            guard let self else { return }
            view?.configure(with: responder, announcementDescription: announcementDescription, feedbacks: feedbacks)
        }.catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
    
    func seeAllTapped() {
        self.coordinator?.showFeedbacks(userId: responder.userId)
    }
}
