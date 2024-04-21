//
//  NewRequestCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation
import UIKit

protocol INewRequestCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    
    func onBackTapped(completion: Completion?)
    func startCreationFlow()
    func showCategorySelectionView(announcement: Announcement)
    func showDescriptionSetupView(announcement: Announcement)
    func showPriceSetupView(announcement: Announcement)
    func showRequestSummaryView(announcement: Announcement)
    func presentAlert(input: AlertInput)
    func popToRoot()
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
    
    func startCreationFlow() {
        let typeSelectionView = moduleFactory.makeTypeSelectionView(coordinator: self)
        router.push(typeSelectionView)
    }
    
    func showCategorySelectionView(announcement: Announcement) {
        let categorySelectionView = moduleFactory.makeCategorySelectionView(announcement: announcement, coordinator: self)
        router.push(categorySelectionView)
    }
    
    func showDescriptionSetupView(announcement: Announcement) {
        let descriptionSetupView = moduleFactory.makeDescriptionSetupView(announcement: announcement, coordinator: self)
        router.push(descriptionSetupView)
    }
    
    func showPriceSetupView(announcement: Announcement) {
        let priceSetupView = moduleFactory.makePriceSetupView(announcement: announcement, coordinator: self)
        router.push(priceSetupView)
    }
    
    func showRequestSummaryView(announcement: Announcement) {
        let requestSummaryView = moduleFactory.makeRequestSummaryView(announcement: announcement, coordinator: self)
        router.push(requestSummaryView)
    }
    
    func presentAlert(input: AlertInput) {
        let alertController = UIAlertController(title: input.title, message: input.message, preferredStyle: .alert)
        alertController.addAction(title: input.actionTitle ?? "") { _ in
            input.actionCallBack?()
        }
        alertController.addAction(title: input.cancelTitle ?? "") { _ in
            input.cancelActionCallBack?()
        }
        router.presentAlert(alertController, animated: true)
    }
    
    func popToRoot() {
        router.popToRootModule()
    }
}

extension NewRequestCoordinator: INewRequestCoordinator {
    func onBackTapped(completion: Completion?) {
        router.popModule()
        completion?()
    }
}
