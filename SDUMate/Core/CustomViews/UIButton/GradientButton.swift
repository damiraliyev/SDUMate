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
        layer.cornerRadius = 20
        layer.borderColor = UIColor(red: 0.125, green: 0.125, blue: 0.302, alpha: 1).cgColor
        layer.borderWidth = 1
        setupGradientLayer()
    }
    
    private func setupViews() {
        backgroundColor = Asset.background.color
        clipsToBounds = true
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        DispatchQueue.main.async {
            gradientLayer.colors = [
                Asset.background.color,
                UIColor(red: 0.125, green: 0.125, blue: 0.302, alpha: 1).cgColor,
                UIColor(red: 0.114, green: 0.114, blue: 0.333, alpha: 1).cgColor
            ]
            gradientLayer.locations = [0, 0.75, 1]
            gradientLayer.type = .radial
            gradientLayer.startPoint = CGPoint(x: 0, y:  0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
            gradientLayer.cornerRadius = 20
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
