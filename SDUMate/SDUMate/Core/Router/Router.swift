//
//  Router.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 04.07.2023.
//

import UIKit
import Swinject
import PanModal

typealias Completion = () -> Void

enum PresentType {
    case panModal
    case navigation
    case navWithPanModal
    case present
}

enum PushType {
    case panModal
    case defaultPush
}

final class Router: Presentable {
    private var assembler: Assembler!
    private(set) weak var navigationController: CoordinatorNavigationController?
    private var completions: [UIViewController : () -> Void]
    
    init(navigationController: CoordinatorNavigationController) {
        self.navigationController = navigationController
        completions = [:]
    }
    
    var rootController: UIViewController? {
        navigationController?.viewControllers.first
    }
    
    var topController: UIViewController? {
        navigationController?.viewControllers.last
    }
    
    func toPresent() -> UIViewController? {
        navigationController
    }
    
    func presented() -> UIViewController? {
        navigationController?.presentedViewController
    }
    
    func showAlert(input: AlertInput) {
        navigationController?.showAlert(input: input)
    }
    
    func showAlertWithoutCancel(input: AlertInput, style: UIAlertAction.Style) {
        navigationController?.showAlertWithoutCancel(input: input, style: style)
    }
    
    func showSuccessAlert(message: String, actionHandler: (() -> Void)?) {
        topController?.showSuccessAlert(with: message, actionHandler: actionHandler)
    }
    
    func showErrorAlert(error: String) {
        navigationController?.showErrorAlert(error: error)
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func presentOnTop(_ module: UIViewController, animated: Bool, presentType: PresentType = .present) {
        switch presentType {
        case .panModal:
            if let controller = module as? UIViewController & PanModalPresentable {
                if navigationController?.presentedViewController == nil {
                    navigationController?.presentPanModal(controller)
                } else {
                    navigationController?.presentedViewController?.presentPanModal(controller)
                }
            }
        default:
            if navigationController?.presentedViewController == nil {
                navigationController?.present(module, animated: animated)
            } else {
                navigationController?.presentedViewController?.present(module, animated: true)
            }
        }
        
    }
    
    func presentFromAnywhere(_ module: Presentable, animated: Bool, modalPresentationStyle: UIModalPresentationStyle = .overFullScreen) {
        guard let controller = module as? CoordinatorNavigationController else { return }
        controller.modalPresentationStyle = modalPresentationStyle
        if navigationController?.presentedViewController == nil {
            topController?.present(controller, animated: animated)
        } else {
            navigationController?.presentedViewController?.present(controller, animated: animated)
        }
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        present(module, animated: animated, presentType: .present)
    }
    
    func present(_ module: Presentable?, animated: Bool, presentType: PresentType) {
        present(module, animated: animated, presentType: presentType, modalPresentationStyle: .fullScreen, modalTransitionStyle: .coverVertical)
    }
    
    func present(_ module: Presentable?, animated: Bool, presentType: PresentType = .present, modalPresentationStyle: UIModalPresentationStyle = .fullScreen, modalTransitionStyle: UIModalTransitionStyle = .coverVertical) {
        switch presentType {
        case .panModal:
            if let controller = module?.toPresent() as? UIViewController & PanModalPresentable {
                topController?.presentPanModal(controller)
            }
        case .navigation:
            if let navController = module as? CoordinatorNavigationController {
                navController.modalPresentationStyle = modalPresentationStyle
                navController.modalTransitionStyle = modalTransitionStyle
                topController?.present(navController, animated: animated)
            }
        case .navWithPanModal:
            if let navController = module as? CoordinatorNavigationController {
                topController?.toPresent()?.presentPanModal(navController)
            }
        case .present:
            guard let controller = module?.toPresent() else { return }
            controller.modalPresentationStyle = modalPresentationStyle
            controller.modalTransitionStyle = modalTransitionStyle
            topController?.present(controller, animated: animated)
        }
    }
    
    func presentAlert(_ alertController: UIAlertController, animated: Bool) {
        if navigationController?.presentedViewController == nil {
            navigationController?.present(alertController, animated: animated)
        } else {
            navigationController?.presentedViewController?.present(alertController, animated: true)
        }
    }
    
    func push(_ module: Presentable?, animated: Bool = true, enableSwipeBack: Bool = true, completion: Completion? = nil) {
        guard let controller = module?.toPresent(), controller is UINavigationController == false else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        if let completion = completion {
            completions[controller] = completion
        }
        enableSwipeBack ? navigationController?.enableSwipeBack() : navigationController?.disableSwipeBack()
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    func dismissModule(animated: Bool = true, completion: Completion? = nil) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
    
    func dismissPresentedView(animated: Bool = true, completion: Completion? = nil) {
        guard let presenterViewController = topController?.presentedViewController else {
            return
        }
        presenterViewController.dismiss(animated: animated, completion: completion)
    }
    
    func dismissWholeModule(animated: Bool = true, completion: Completion? = nil) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: animated, completion: completion)
    }
    
    func popToModule(_ module: Presentable, animated: Bool = true) {
        guard let viewController = module.toPresent() else { return }
        navigationController?.popToViewController(viewController, animated: animated)
    }
    
    func popModule(animated: Bool = true) {
        if let controller = navigationController?.popViewController(animated: animated) {
            runCompletions(for: controller)
        }
    }
    
    func setRootModule(_ module: Presentable?, isNavigationBarHidden: Bool = true) {
        guard let controller = module?.toPresent() else { return }
        navigationController?.setViewControllers([controller], animated: false)
        navigationController?.isNavigationBarHidden = isNavigationBarHidden
    }
    
    func popToRootModule(animated: Bool = true) {
        if let controllers = navigationController?.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletions(for: $0)}
        }
    }
    
    private func runCompletions(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
