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
    func showFilterView()
    func showAnnouncementDetailsView()
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
    
    func showFilterView() {
        let filterViewController = FilterViewController()
        router.present(filterViewController, animated: true, presentType: .panModal)
    }
    
    func showAnnouncementDetailsView() {
        let announcementDescriptionView = moduleFactory.makeAnnouncementDetailsView(coordinator: self)
        router.push(announcementDescriptionView)
    }
}
