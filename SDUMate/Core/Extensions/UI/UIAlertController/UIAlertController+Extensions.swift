//
//  UIAlertController+Extensions.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 28.09.2023.
//

import UIKit

extension UIAlertController {
    private enum Constants {
        static let contentViewController = "contentViewController"
        static let titleTextColor = "titleTextColor"
    }
    convenience init(style: UIAlertController.Style, source: UIView? = nil, title: String? = nil, message: String? = nil, tintColor: UIColor? = nil) {
        self.init(title: title, message: message, preferredStyle: style)
        
        if let color = tintColor {
            self.view.tintColor = color
        }
    }
    
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: Constants.contentViewController)
        if let height = height {
            vc.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
    
    func addDatePicker(mode: UIDatePicker.Mode, style: UIDatePickerStyle = .wheels, height: CGFloat = 200, minimumDate: Date? = nil, maximumDate: Date? = nil, action: DatePickerViewController.Action?) {
        let datePicker = DatePickerViewController(mode: mode, pickerStyle: style, minDate: minimumDate, maxDate: maximumDate, action: action)
        set(vc: datePicker, height: height)
    }
    
    func addAction(image: UIImage? = nil, title: String, color: UIColor? = nil, style: UIAlertAction.Style = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        if let color = color {
            action.setValue(color, forKey: Constants.titleTextColor)
        }
        addAction(action)
    }
}

