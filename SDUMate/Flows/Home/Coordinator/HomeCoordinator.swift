//
//  HomeCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 17.03.2024.
//

import Foundation

protocol IHomeCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    
    func onBackTapped(completion: Completion?)
    func dismissPresenterModule(completion: Completion?)
    func showFilterView()
    func showAnnouncementDetailsView(with announcement: Announcement)
    func showInvitationsView()
}

final class HomeCoordinator: BaseCoordinator, TababbleCoordinator {
    var onOwnerTabBarNeedsToBeChanged: ((OwnerTabBarItem) -> Void)?
    var tabCoordinatorDelegate: TabCoordinatorDelegate?
    
    private let container: DependencyContainer
    private let moduleFactory: HomeModuleFactory
    var onFlowDidFinish: Completion?
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        moduleFactory = HomeModuleFactory(container: container)
        super.init(router: router)
    }
    
    override func start() {
        let homeView = moduleFactory.makeHomeView(coordinator: self)
        router.setRootModule(homeView)
    }
}

extension HomeCoordinator: IHomeCoordinator {
    func onBackTapped(completion: Completion?) {
        router.popModule()
        completion?()
    }
    
    func dismissPresenterModule(completion: Completion?) {
        router.dismissModule {
            completion?()
        }
    }
    
    func showFilterView() {
        let filterViewController = moduleFactory.makeFilterView(coordinator: self)
        router.present(filterViewController, animated: true, presentType: .panModal)
    }
    
    func showAnnouncementDetailsView(with announcement: Announcement) {
        let announcementDescriptionView = moduleFactory.makeAnnouncementDetailsView(announcement: announcement, coordinator: self)
        router.push(announcementDescriptionView)
    }
    
    func showInvitationsView() {
        let invitationsView = moduleFactory.makeInvitationsView(coordinator: self)
        router.push(invitationsView)
    }
}
