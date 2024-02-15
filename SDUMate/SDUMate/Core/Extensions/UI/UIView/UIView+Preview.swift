//
//  UIView+Preview.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 06.09.2023.
//
import UIKit
import SwiftUI

extension UIView {
    
    private struct Preview: UIViewRepresentable {
        typealias UIViewType = UIView
        let view: UIView
        
        func makeUIView(context: Context) -> UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) { }
    }
    
    func showPreview() -> some View {
        Preview(view: self)
    }
}
