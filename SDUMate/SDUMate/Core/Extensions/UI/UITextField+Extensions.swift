//
//  UITextField+Extensions.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 14.09.2023.
//

import UIKit

extension UITextField {
    @IBInspectable var doneAccessory: Bool {
        get {
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone {
                addDoneButtonOnKeyboard()
            } else {
                deleteDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        doneToolbar.barStyle = .default
        doneToolbar.backgroundColor = .beProWhite
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: CoreL10n.done, style: .done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = .dark
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    func deleteDoneButtonOnKeyboard() {
        self.inputAccessoryView = nil
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
