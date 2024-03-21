//
//  OwnerTabBarCoordinatorFactory.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 04.07.2023.
//

import UIKit


final class TarBarCoordinatorFactory {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeHomeModule() -> (coordinator: TababbleCoordinator, module: Presentable) {
        let navigationController = CoordinatorNavigationController()
        navigationController.tabBarItem.image = Asset.icTabHome.image
        let router = Router(navigationController: navigationController)
        let coordinator = HomeCoordinator(router: router, container: container)
        return (coordinator, navigationController)
    }
    
    func makeSessionsModule() -> (coordinator: TababbleCoordinator, module: Presentable) {
        let navigationController = CoordinatorNavigationController()
        navigationController.tabBarItem.image = Asset.icTabSessions.image
        let router = Router(navigationController: navigationController)
        let coordinator = SessionsCoordinator(router: router, container: container)
        return (coordinator, navigationController)
    }
    
    func makeNewRequestModule() -> (coordinator: TababbleCoordinator, module: Presentable) {
        let navigationController = CoordinatorNavigationController()
        navigationController.tabBarItem.image = Asset.icTabNew.image
        let router = Router(navigationController: navigationController)
        let coordinator = NewRequestCoordinator(router: router, container: container)
        return (coordinator, navigationController)
    }
    
    func makeRatingModule() -> (coordinator: TababbleCoordinator, module: Presentable) {
        let navigationController = CoordinatorNavigationController()
        navigationController.tabBarItem.image = Asset.icTabRating.image
        let router = Router(navigationController: navigationController)
        let coordinator = RatingCoordinator(router: router, container: container)
        return (coordinator, navigationController)
    }
    
    func makeSettingsModule() -> (coordinator: TababbleCoordinator, module: Presentable) {
        let navigationController = CoordinatorNavigationController()
        navigationController.tabBarItem.image = Asset.icTabProfile.image
        let router = Router(navigationController: navigationController)
        let coordinator = SettingsCoordinator(router: router, container: container)
        return (coordinator, navigationController)
    }
    
}
