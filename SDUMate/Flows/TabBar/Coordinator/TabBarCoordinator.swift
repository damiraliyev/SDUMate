////
////  OwnerTabBarCoordinator.swift
////  BePRO
////
////  Created by Nurkanat Klimov on 05.07.2023.
////
//
//import UIKit
//
//struct TabableRootControllerAndCoordinatorContainer {
//    var viewController: UIViewController
//    var coordinator: TababbleCoordinator
//}
//
//final class TabBarCoordinator: BaseCoordinator {
//    private var coordinatorFactory: TarBarCoordinatorFactory
//    private var tabRootContainers: [TabableRootControllerAndCoordinatorContainer] = []
//    private var tabBarController: TabBarController
//    
//    private var homeCoordinator: TababbleCoordinator?
//    private var sessionsCoordinator: TababbleCoordinator?
//    private var newRequestCoordinator: TababbleCoordinator?
//    private var ratingCoordinator: TababbleCoordinator?
//    private var settingsCoordinator: TababbleCoordinator?
//
//    init(router: Router, container: DependencyContainer) {
//        coordinatorFactory = TarBarCoordinatorFactory(container: container)
//        tabBarController = TabBarController()
//        super.init(router: router)
//    }
//
//    override func start() {
//        setupAllFlows()
//        let viewControllers = tabRootContainers.map { $0.viewController }
//        tabBarController.setViewControllers(viewControllers)
//        router.setRootModule(tabBarController)
//    }
//    
//    private func setupAllFlows() {
//        setupHomeFlow()
//        setupEmployeesFlow()
//        setupTrelloFlow()
//        setupDMSFlow()
//        setupSettingsFlow()
//    }
//    
//    private func setupHomeFlow() {
//        let (homeCoordinator, rootController) = coordinatorFactory.makeHomeModule()
//        homeCoordinator.start()
//        homeCoordinator.tabCoordinatorDelegate = self
//        addDependency(homeCoordinator)
//        guard let controller = rootController.toPresent() else { return }
//        self.homeCoordinator = homeCoordinator
//        tabRootContainers.append(
//            TabableRootControllerAndCoordinatorContainer(
//                viewController: controller,
//                coordinator: homeCoordinator
//            )
//        )
//    }
//    
//    private func setupEmployeesFlow() {
//        let (employeesCoordinator, rootController) = coordinatorFactory.makeEmployeesModule()
//        employeesCoordinator.start()
//        employeesCoordinator.tabCoordinatorDelegate = self
//        addDependency(employeesCoordinator)
//        guard let controller = rootController.toPresent() else { return }
//        self.employeesCoordinator = employeesCoordinator
//        tabRootContainers.append(
//            TabableRootControllerAndCoordinatorContainer(
//                viewController: controller,
//                coordinator: employeesCoordinator
//            )
//        )
//    }
//    
//    private func setupTrelloFlow() {
//        let (trelloCoordinator, rootCoordinator) = coordinatorFactory.makeTrelloModule()
//        trelloCoordinator.start()
//        trelloCoordinator.tabCoordinatorDelegate = self
//        addDependency(trelloCoordinator)
//        guard let controller = rootCoordinator.toPresent() else { return }
//        self.trelloCoordinator = trelloCoordinator
//        tabRootContainers.append(
//            TabableRootControllerAndCoordinatorContainer(
//                viewController: controller,
//                coordinator: trelloCoordinator
//            )
//        )
//    }
//    
//    private func setupDMSFlow() {
//        let (dmsCoordinator, rootCoordinator) = coordinatorFactory.makeDMSModule()
//        dmsCoordinator.start()
//        addDependency(dmsCoordinator)
//        guard let controller = rootCoordinator.toPresent() else { return }
//        self.dmsCoordinator = dmsCoordinator
//        tabRootContainers.append(
//            TabableRootControllerAndCoordinatorContainer(
//                viewController: controller,
//                coordinator: dmsCoordinator)
//        )
//    }
//
//    private func setupSettingsFlow() {
//        let (settingsCoordinator, rootCoordinator) = coordinatorFactory.makeSettingsModule()
//        settingsCoordinator.start()
//        settingsCoordinator.tabCoordinatorDelegate = self
//        addDependency(settingsCoordinator)
//        guard let controller = rootCoordinator.toPresent() else { return }
//        self.settingsCoordinator = settingsCoordinator
//        tabRootContainers.append(
//            TabableRootControllerAndCoordinatorContainer(
//                viewController: controller,
//                coordinator: settingsCoordinator
//            )
//        )
//    }
//}
//
//extension TabBarCoordinator: TabCoordinatorDelegate {
//    
//}
