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
    }
    
    @objc private func authDataDidChange() {
        start()
    }
    
    private func runOnboardingFlow() {
        
    }
    
    private func clearAll() {
        tabBarCoordinator = nil
    }
    
    private func runAuthFlow() {
//        let coordinator = coordinatorFactory.makeAuthCoordinator()
//        coordinator.onFlowDidFinish = { [weak self, weak coordinator] in
//            guard let self else { return }
//            self.removeDependency(coordinator)
//            guard let role = UserSettings().userData?.role else { return }
//            self.userRole = role
//            self.runMainFlow(for: role)
//        }
//        addDependency(coordinator)
//        coordinator.start()
    }
    
    private func runMainFlow() {
//        let coordinator: Coordinator = coordinatorFactory.makeMainOwnerTabBarCoordinator()
//        tabBarCoordinator = coordinator
//        addDependency(coordinator)
//        coordinator.start()
    }
}
