//
//  OwnerTabBarCoordinator.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 05.07.2023.
//

import UIKit

struct TabableRootControllerAndCoordinatorContainer {
    var viewController: UIViewController
    var coordinator: TababbleCoordinator
}

final class TabBarCoordinator: BaseCoordinator {
    private var coordinatorFactory: TarBarCoordinatorFactory
    private var tabRootContainers: [TabableRootControllerAndCoordinatorContainer] = []
    private var tabBarController: TabBarController
    
    private var homeCoordinator: TababbleCoordinator?
    private var sessionsCoordinator: TababbleCoordinator?
    private var newRequestCoordinator: TababbleCoordinator?
    private var ratingCoordinator: TababbleCoordinator?
    private var settingsCoordinator: TababbleCoordinator?

    init(router: Router, container: DependencyContainer) {
        coordinatorFactory = TarBarCoordinatorFactory(container: container)
        tabBarController = TabBarController()
        super.init(router: router)
    }
    
    override func start() {
        setupAllFlows()
        let viewControllers = tabRootContainers.map { $0.viewController }
        tabBarController.setViewControllers(viewControllers)
        router.setRootModule(tabBarController)
    }
    
    private func setupAllFlows() {
        setupHomeFlow()
    }
    
    private func setupHomeFlow() {
        let (homeCoordinator, rootController) = coordinatorFactory.makeHomeModule()
        homeCoordinator.start()
        homeCoordinator.tabCoordinatorDelegate = self
        addDependency(homeCoordinator)
        guard let controller = rootController.toPresent() else { return }
        self.homeCoordinator = homeCoordinator
        tabRootContainers.append(
            TabableRootControllerAndCoordinatorContainer(
                viewController: controller,
                coordinator: homeCoordinator
            )
        )
    }
    
    private func setupSessionsFlow() {
        let (sessionsCoordinator, rootController) = coordinatorFactory.makeSessionsModule()
        sessionsCoordinator.start()
        sessionsCoordinator.tabCoordinatorDelegate = self
        addDependency(sessionsCoordinator)
        guard let controller = rootController.toPresent() else { return }
        self.sessionsCoordinator = sessionsCoordinator
        tabRootContainers.append(
            TabableRootControllerAndCoordinatorContainer(
                viewController: controller,
                coordinator: sessionsCoordinator
            )
        )
    }
    
    private func setupNewRequestFlow() {
        let (newRequestCoordinator, rootController) = coordinatorFactory.makeNewRequestModule()
        newRequestCoordinator.start()
        newRequestCoordinator.tabCoordinatorDelegate = self
        addDependency(newRequestCoordinator)
        guard let controller = rootController.toPresent() else { return }
        self.newRequestCoordinator = newRequestCoordinator
        tabRootContainers.append(
            TabableRootControllerAndCoordinatorContainer(
                viewController: controller,
                coordinator: newRequestCoordinator
            )
        )
    }
    
    private func setupRatingFlow() {
        let (ratingCoordinator, rootController) = coordinatorFactory.makeRatingModule()
        ratingCoordinator.start()
        ratingCoordinator.tabCoordinatorDelegate = self
        addDependency(ratingCoordinator)
        guard let controller = rootController.toPresent() else { return }
        self.ratingCoordinator = ratingCoordinator
        tabRootContainers.append(
            TabableRootControllerAndCoordinatorContainer(
                viewController: controller,
                coordinator: ratingCoordinator
            )
        )
    }
    
    private func setupSettingsModule() {
        let (settingsCoordinator, rootController) = coordinatorFactory.makeSettingsModule()
        settingsCoordinator.start()
        settingsCoordinator.tabCoordinatorDelegate = self
        addDependency(settingsCoordinator)
        guard let controller = rootController.toPresent() else { return }
        self.settingsCoordinator = settingsCoordinator
        tabRootContainers.append(
            TabableRootControllerAndCoordinatorContainer(
                viewController: controller,
                coordinator: settingsCoordinator
            )
        )
    }
}

extension TabBarCoordinator: TabCoordinatorDelegate {
    
}
