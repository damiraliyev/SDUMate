//
//  OwnerTabBarCoordinatorFactory.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 04.07.2023.
//

//import UIKit
//
//
//final class TarBarCoordinatorFactory {
//    private let container: DependencyContainer
//    
//    init(container: DependencyContainer) {
//        self.container = container
//    }
//    
//    func makeHomeModule() -> (coordinator: TababbleCoordinator, module: Presentable) {
//        let navigationController = CoordinatorNavigationController()
//        navigationController.tabBarItem.image = Asset.icHome.image
//        let router = Router(navigationController: navigationController)
//        let coordinator = OwnerHomeCoordinator(router: router, container: container)
//        return (coordinator, navigationController)
//    }
//    
//    func makeEmployeesModule() -> (coordinator: TababbleCoordinator, module: Presentable) {
//        let navigationController = CoordinatorNavigationController()
//        navigationController.tabBarItem.image = Asset.icList.image
//        let coordinator = EmployeesCoordinator(router: Router(navigationController: navigationController), container: container)
//        return (coordinator, navigationController)
//    }
//
//    func makeTrelloModule() -> (coordinator: TababbleCoordinator, module: Presentable) {
//        let navigationController = CoordinatorNavigationController()
//        navigationController.tabBarItem.image = Asset.icTrello.image
//        let coordinator = OnwerTrelloCoordinator(router: Router(navigationController: navigationController), container: self.container)
//        return (coordinator, navigationController)
//    }
//    
//    func makeDMSModule() -> (coordinator: TababbleCoordinator, module: Presentable) {
//        let navigationController = CoordinatorNavigationController()
//        navigationController.tabBarItem.image = Asset.icDocumentManagement24px.image
//        let coordinator = OwnerDMSCoordinator(router: Router(navigationController: navigationController), container: container)
//        return (coordinator, navigationController)
//    }
//
//    func makeSettingsModule() -> (coordinator: TababbleCoordinator, module: Presentable) {
//        let navigationController = CoordinatorNavigationController()
//        navigationController.tabBarItem.image = Asset.icSettings.image
//        let coordinator = OwnerSettingsCoordinator(router: Router(navigationController: navigationController), container: container)
//        return (coordinator, navigationController)
//    }
//    
//    func makeGambyCardsModule(gambyResponse: [GambyResponse]) -> (coordinator: GambyCardsCoordinator, module: Presentable) {
//        let navigationController = CoordinatorNavigationController()
//        let coordinator = GambyCardsCoordinator(
//            router: Router(navigationController: navigationController),
//            container: container,
//            response: gambyResponse,
//            userRole: .owner
//        )
//        return (coordinator, navigationController)
//    }
//}
