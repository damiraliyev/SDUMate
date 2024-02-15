//
//  AppCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Moya
import UIKit

final class AppCoordinator: BaseCoordinator {
    private let container: DependencyContainer
    private var tabBarCoordinator: Coordinator?
    private let coordinatorFactory: AppCordinatorFactory
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        coordinatorFactory = AppCordinatorFactory(router: router, container: container)
        super.init(router: router)
    }
    
    override func start() {
        clearAll()
        runAuthFlow()
    }
    
    @objc private func authDataDidChange() {
        start()
        runAuthFlow()
    }
    
    private func runOnboardingFlow() {
        
    }
    
    private func clearAll() {
        tabBarCoordinator = nil
        clearChildCoordinators()
    }
    
    private func runAuthFlow() {
        let coordinator = coordinatorFactory.makeAuthCoordinator()
        coordinator.onFlowDidFinish = { [weak self, weak coordinator] in
            guard let self else { return }
            removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMainFlow() {
//        let coordinator: Coordinator = coordinatorFactory.makeMainOwnerTabBarCoordinator()
//        tabBarCoordinator = coordinator
//        addDependency(coordinator)
//        coordinator.start()
    }
}
