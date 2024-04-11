//
//  SessionsModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

final class SessionsModuleFactory {
    private let container: DependencyContainer
    private let announcementDetailsManager: AnnouncementDetailsManager
    
    init(container: DependencyContainer) {
        self.container = container
        self.announcementDetailsManager = container.resolve(AnnouncementDetailsManager.self)!
    }
    
    func makeSessionsView(coordinator: ISessionsCoordinator) -> ISessionsView {
        let view: ISessionsView = SessionsViewController()
        let presenter: ISessionsPresenter = SessionsPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makeHomeCoordinator(router: Router) -> IHomeCoordinator & Coordinator {
        let coordinator: IHomeCoordinator & Coordinator = HomeCoordinator(router: router, container: container)
        return coordinator
    }
    
    func makeResponderInfoView(responder: DBUser, announcementDescription: String, coordinator: IAnnouncementResponderInfoCoordinator) -> IAnnouncementResponderInfoView {
        let view: IAnnouncementResponderInfoView = AnnouncementResponderInfoViewController()
        let presenter: IAnnouncementResponderInfoPresenter = AnnouncementResponderInfoPresenter(responder: responder, announcementDescription: announcementDescription, view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makeAnnouncementDetailsView(announcement: Announcement, announcer: DBUser, respondent: DBUser,coordinator: ISessionsCoordinator) -> ISessionAnnouncementInfoView {
        let view: ISessionAnnouncementInfoView = SessionAnnouncementInfoViewController(announcement: announcement, announcer: announcer, respondent: respondent)
        let presenter: ISessionAnnouncementInfoPresenter = SessionAnnouncementInfoPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
