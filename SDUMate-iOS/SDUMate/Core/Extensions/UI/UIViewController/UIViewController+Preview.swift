//
//  UIViewController+Preview.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 06.09.2023.
//
import UIKit
import SwiftUI

extension UIViewController {
    
    private struct Preview: UIViewControllerRepresentable {
        
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    }
    
    func showPreview() -> some View {
        Preview(viewController: self)
    }
}
