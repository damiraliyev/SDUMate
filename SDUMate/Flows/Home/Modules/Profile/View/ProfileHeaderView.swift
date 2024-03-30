//
//  ProfileHeaderView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 27.03.2024.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icImagePlaceholder.image
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let userInfoView = ProfileUserInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    private func setupViews() {
        backgroundColor = .clear
        addSubviews([userInfoView, profileImageView])
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(110)
        }
        userInfoView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(-40)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 382, height: 323)
    }
}
