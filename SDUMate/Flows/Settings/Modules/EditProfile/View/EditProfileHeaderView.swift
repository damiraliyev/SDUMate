//
//  EditProfileHeaderView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import UIKit

final class EditProfileHeaderView: UIView {
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icImagePlaceholder.image
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var selectPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select photo", for: .normal)
        button.setTitleColor(.lavender, for: .normal)
        button.titleLabel?.font = .regular16
        return button
    }()
    
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
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(frame.height / 1.5)
        }
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
    
    private func setupViews() {
        backgroundColor = .clear
        addSubviews([avatarImageView, selectPhotoButton])
    }
    
    private func setupConstraints() {
        selectPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
    }
}
