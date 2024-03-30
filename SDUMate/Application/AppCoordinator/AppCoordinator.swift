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
    private let authManager: AuthManager
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        self.authManager = container.resolve(AuthManager.self)!
        coordinatorFactory = AppCordinatorFactory(router: router, container: container)
        super.init(router: router)
    }
    
    override func start() {
        clearAll()
        startProperCoordinator()
    }
    
    private func startProperCoordinator() {
        if authManager.getAuthUser() == nil {
            runAuthFlow()
        } else {
            runMainFlow()
        }
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
            runMainFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMainFlow() {
        let coordinator: Coordinator = coordinatorFactory.makeTabBarCoordinator(tabBarDelegate: self)
        tabBarCoordinator = coordinator
        addDependency(coordinator)
        coordinator.start()
    }
}

extension AppCoordinator: TabCoordinatorDelegate {
    func didTapLogOut() {
        clearAll()
        startProperCoordinator()
    }
}
