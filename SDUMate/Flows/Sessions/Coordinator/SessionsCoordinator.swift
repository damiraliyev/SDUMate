//
//  SessionsCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

import Foundation

protocol ISessionsCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    
    func onBackTapped(completion: Completion?)
    func showAnnouncementDetailsView(with announcement: Announcement)
}

final class SessionsCoordinator: BaseCoordinator, TababbleCoordinator {
    var onOwnerTabBarNeedsToBeChanged: ((OwnerTabBarItem) -> Void)?
    var tabCoordinatorDelegate: TabCoordinatorDelegate?
    
    private let container: DependencyContainer
    private let moduleFactory: SessionsModuleFactory
    var onFlowDidFinish: Completion?
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        moduleFactory = SessionsModuleFactory(container: container)
        super.init(router: router)
    }
    
    override func start() {
        let sessionView = moduleFactory.makeSessionsView(coordinator: self)
        router.setRootModule(sessionView)
    }
}

extension SessionsCoordinator: ISessionsCoordinator {
    func onBackTapped(completion: Completion?) {
        
    }
    
    func showAnnouncementDetailsView(with announcement: Announcement) {
        let homeCoordinator = moduleFactory.makeHomeCoordinator(router: router)
        addDependency(homeCoordinator)
        homeCoordinator.onFlowDidFinish = { [weak self, weak homeCoordinator] in
            self?.removeDependency(homeCoordinator)
        }
        let announcementDescriptionView = moduleFactory.makeAnnouncementDetailsView(announcement: announcement, coordinator: homeCoordinator)
        router.push(announcementDescriptionView)
    }
}
