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
    
    func makeAnnouncementDetailsView(announcement: Announcement, coordinator: IHomeCoordinator) -> IAnnouncementDetailsView {
        let view: IAnnouncementDetailsView = AnnouncementDetailsViewController(announcement: announcement)
        let presenter: IAnnouncementDetailsPresenter = AnnouncementDetailsPresenter(view: view, coordinator: coordinator, manager: announcementDetailsManager)
        let backTappedCompetion: Completion = { [weak coordinator] in
            coordinator?.onBackTapped(completion: {
                coordinator?.onFlowDidFinish?()
            })
        }
        presenter.onBackTapped = {
            backTappedCompetion()
        }
        view.presenter = presenter
        return view
    }
}
