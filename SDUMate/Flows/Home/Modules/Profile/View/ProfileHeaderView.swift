//
//  ProfileHeaderView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 27.03.2024.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func changeTapped()
}

final class ProfileHeaderView: UIView {
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icImagePlaceholder.image
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change", for: .normal)
        button.setTitleColor(.lavender, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(changeTapped), for: .touchUpInside)
        return button
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
    
    @objc func changeTapped() {
        delegate?.changeTapped()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 382, height: 323)
    }
}
