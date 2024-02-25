//
//  GradientButton.swift
//  SDUMate
//
//  Created by Damir Aliyev on 24.02.2024.
//

import UIKit

final class GradientButton: UIButton {
    
    init(title: String, font: UIFont) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.borderColor = UIColor(red: 0.125, green: 0.125, blue: 0.302, alpha: 1).cgColor
        layer.borderWidth = 1
        setupGradientLayer()
    }
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        DispatchQueue.main.async {
            gradientLayer.colors = [
                UIColor.hexStringToUIColor(hex: "#060741").cgColor,
                UIColor.hexStringToUIColor(hex: "#2D4A8A").cgColor,
                UIColor.hexStringToUIColor(hex: "#060741").cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0.15, y:  0.5)
            gradientLayer.endPoint = CGPoint(x: 0.85, y: 0.5)
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = 10
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
