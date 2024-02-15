//
//  UIViewController+Extension.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 04.07.2023.
//

import UIKit

import SwiftUI

extension UIViewController {
    func showAlert(title: String?, message: String?, actionTitle: String = "Ok", actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: actionHandler)
        action.setValue(UIColor.dark, forKey: GlobalConstants.titleTextColor)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    func showSuccessAlert(with message: String, actionHandler: (() -> Void)? = nil) {
        let successAlertController = SuccessAlertController(message: message, actionHandler: actionHandler)
        successAlertController.appear(self)
    }
    
    @objc private func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
