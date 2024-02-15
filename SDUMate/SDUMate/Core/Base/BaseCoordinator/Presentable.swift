//
//  Presentable.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 04.07.2023.
//

import UIKit

protocol Presentable: AnyObject {
    func toPresent() -> UIViewController?
    func showAlert(input: AlertInput)
    func showAlertWithoutCancel(input: AlertInput, style: UIAlertAction.Style)
    func showErrorAlert(error: String)
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        self
    }
    
    func showAlert(input: AlertInput) {
        let alertController = UIAlertController(title: input.title, message: input.message, preferredStyle: .alert)
        let action = UIAlertAction(title: input.actionTitle, style: .default) { _ in
            input.actionCallBack?()
        }
        let cancel = UIAlertAction(title: input.cancelTitle, style: .cancel) { _ in
            input.cancelActionCallBack?()
        }
        alertController.addAction(cancel)
        alertController.addAction(action)
        safePresent(alertController: alertController)
    }
    
    func showAlertWithoutCancel(input: AlertInput, style: UIAlertAction.Style) {
        let alert = UIAlertController(title: input.title, message: input.message, preferredStyle: .alert)
        let action = UIAlertAction(title: input.actionTitle, style: style) { _ in
            input.actionCallBack?()
        }
        action.setValue(UIColor.dark, forKey: GlobalConstants.titleTextColor)
        alert.addAction(action)
        safePresent(alertController: alert)
    }
    
    func showErrorAlert(error: String) {
        let alertController = UIAlertController(style: .alert, title: CoreL10n.error, message: error)
        let okAction = UIAlertAction(title: CoreL10n.ok, style: .default, handler: nil)
        okAction.setValue(UIColor.dark, forKey: GlobalConstants.titleTextColor)
        alertController.addAction(okAction)
        safePresent(alertController: alertController)
    }
    
    func safePresent(alertController: UIAlertController) {
        if let presentedViewController = self.presentedViewController {
            presentedViewController.present(alertController, animated: true)
        } else {
            present(alertController, animated: true)
        }
    }
}
