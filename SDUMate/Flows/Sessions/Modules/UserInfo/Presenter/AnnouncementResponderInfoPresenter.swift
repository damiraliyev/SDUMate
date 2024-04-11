//
//  UserInfoPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.04.2024.
//

import Foundation

protocol IAnnouncementResponderInfoCoordinator: IBaseCoordinator {
    func backTapped(completion: Completion?)
}

protocol IAnnouncementResponderInfoPresenter: AnyObject {
    func backTapped()
    func viewDidLoad()
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
        coordinator?.backTapped(completion: nil)
    }
    
    func viewDidLoad() {
        view?.configure(with: responder, announcementDescription: announcementDescription)
    }
}
