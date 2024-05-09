//
//  RatingCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol IRatingCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    
    func onBackTapped(completion: Completion?)
    func showTopContrubitorInfoView(user: DBUser, type: TopContributorType, place: Int)
}

final class RatingCoordinator: BaseCoordinator, TababbleCoordinator {
    var onOwnerTabBarNeedsToBeChanged: ((OwnerTabBarItem) -> Void)?
    var tabCoordinatorDelegate: TabCoordinatorDelegate?
    
    private let container: DependencyContainer
    private let moduleFactory: RatingModuleFactory
    var onFlowDidFinish: Completion?
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        moduleFactory = RatingModuleFactory(container: container)
        super.init(router: router)
    }
    
    override func start() {
        let ratingView = moduleFactory.makeRatingView(coordinator: self)
        router.setRootModule(ratingView)
    }
    
    func showTopContrubitorInfoView(user: DBUser, type: TopContributorType, place: Int) {
        let view = TopContributorInfoViewController(user: user, type: type, place: place)
        router.present(view, animated: true, presentType: .present, modalPresentationStyle: .overFullScreen)
    }
}

extension RatingCoordinator: IRatingCoordinator {
    func onBackTapped(completion: Completion?) {
        
    }
}
