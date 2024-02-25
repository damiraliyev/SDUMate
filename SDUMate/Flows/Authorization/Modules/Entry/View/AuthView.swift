//
//  AuthView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 25.02.2024.
//

import UIKit

final class AuthView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.authBackground.image
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.sduLogo.image
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        setupGradient()
        setupConstraints()
    }
    
    private func setupViews() {
//        backgroundColor = Asset.background.color
        addSubviews([backgroundImageView, logoImageView])
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(124)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.frame.height * 0.458)
        }
    }
}
