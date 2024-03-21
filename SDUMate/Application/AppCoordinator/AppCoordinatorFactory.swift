//
//  AppCoordinatorFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Foundation

final class AppCordinatorFactory {
    private let container: DependencyContainer
    private let router: Router
    
    init(router: Router, container: DependencyContainer) {
        self.router = router
        self.container = container
    }
    
    func makeAuthCoordinator() -> Coordinator & IAuthCoordinator {
        let coordinator = AuthCoordinator(
            router: router,
            container: container
        )
        return coordinator
    }
    
    func makeTabBarCoordinator() -> Coordinator {
        TabBarCoordinator(router: router, container: container)
    }
    
    func makeHomeCoordinator() -> IHomeCoordinator & Coordinator {
        let coordinator = HomeCoordinator(router: router, container: container)
        return coordinator
    }
}
