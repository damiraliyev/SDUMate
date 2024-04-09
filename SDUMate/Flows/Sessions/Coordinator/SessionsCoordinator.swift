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
    func showAnnouncementDetailsView(with announcement: Announcement, announcer: DBUser, respondent: DBUser)
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
    
    func showAnnouncementDetailsView(with announcement: Announcement, announcer: DBUser, respondent: DBUser) {
        let announcementDetailsView = moduleFactory.makeAnnouncementDetailsView(announcement: announcement, announcer: announcer, respondent: respondent, coordinator: self)
        router.present(announcementDetailsView, animated: true, presentType: .panModal)
    }
}
