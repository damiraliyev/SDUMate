//
//  NewRequestCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol INewRequestCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    
    func onBackTapped(completion: Completion?)
}

final class NewRequestCoordinator: BaseCoordinator, TababbleCoordinator {
    var onOwnerTabBarNeedsToBeChanged: ((OwnerTabBarItem) -> Void)?
    var tabCoordinatorDelegate: TabCoordinatorDelegate?
    
    private let container: DependencyContainer
    private let moduleFactory: NewRequestModuleFactory
    var onFlowDidFinish: Completion?
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        moduleFactory = NewRequestModuleFactory(container: container)
        super.init(router: router)
    }
    
    override func start() {
        let newRequestView = moduleFactory.makeNewRequestView(coordinator: self)
        router.setRootModule(newRequestView)
    }
}

extension NewRequestCoordinator: INewRequestCoordinator {
    func onBackTapped(completion: Completion?) {
        
    }
}
