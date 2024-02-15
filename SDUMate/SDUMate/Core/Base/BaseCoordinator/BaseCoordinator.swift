//
//  BaseCoordinator.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 04.07.2023.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()
}

protocol IBaseCoordinator: AnyObject {
    var router: Router { get }
    func dismissModule(completion: (() -> Void)?)
    func dismissTopModule(animated: Bool, completion: (() -> Void)?)
    func backTapped(completion: (() -> Void)?)
    func showAlert(title: String?, message: String?)
    func showAlert(with input: AlertInput)
    func showErrorAlert(error: String)
}

extension IBaseCoordinator {
    func dismissModule(completion: (() -> Void)?) { }
    func backTapped(completion: (() -> Void)?) { }
    func showAlert(title: String?, message: String?) { }
    func showAlert(with input: AlertInput) { }
    func showErrorAlert(error: String) {
        router.showErrorAlert(error: error)
    }
    func dismissTopModule(animated: Bool, completion: (() -> Void)?) {}
}

public class BaseCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {}
    
    func dismiss(child coordinator: Coordinator?) {
        router.dismissModule()
    }
    
    func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard !childCoordinators.isEmpty,
              let coordinator = coordinator else { return }
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators.filter { $0 !== coordinator }.forEach { coordinator.removeDependency($0) }
        }
        childCoordinators.removeAll { $0 === coordinator }
    }
    
    func clearChildCoordinators() {
        childCoordinators.forEach { removeDependency($0) }
    }
    
    func showAlert(input: AlertInput) {
        let alert = UIAlertController(title: input.title, message: input.message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: input.cancelTitle, style: .cancel) { _ in
            input.cancelActionCallBack?()
        }
        alert.addAction(cancelAction)
        
        if input.actionCallBack != nil {
            let action = UIAlertAction(title: input.actionTitle, style: .default) { _ in
                input.actionCallBack?()
            }
            cancelAction.setValue(UIColor.accentRed, forKey: GlobalConstants.titleTextColor)
            action.setValue(UIColor.dark, forKey: GlobalConstants.titleTextColor)
            alert.addAction(action)
        }
        router.presentAlert(alert, animated: true)
    }
}
