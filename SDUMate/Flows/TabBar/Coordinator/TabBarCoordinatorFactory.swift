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
    
    
}
