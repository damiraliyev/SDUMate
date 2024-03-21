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
}

final class RatingCoordinator: BaseCoordinator, IRatingCoordinator {
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
    
    func onBackTapped(completion: Completion?) {
        
    }
}
