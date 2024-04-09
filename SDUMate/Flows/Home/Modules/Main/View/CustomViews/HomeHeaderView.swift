//
//  HomeHeaderView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit
import Kingfisher

protocol HomeHeaderViewDelegate: AnyObject {
    func notificationsTapped()
    func profileTapped()
}

final class HomeHeaderView: UIView {
    
    weak var delegate: HomeHeaderViewDelegate?
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icAvatarPlaceholder.image
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = ._282645
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        imageView.addGestureRecognizer(tapRecognizer)
        return imageView
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular16
        label.text = "Damir Aliyev"
        return label
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular16
        label.text = "mntn7"
        return label
    }()
    
    private lazy var bellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.icHeaderBell.image
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(notificationsTapped))
        imageView.addGestureRecognizer(tapRecognizer)
        imageView.isUserInteractionEnabled = true
        return imageView
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
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
    
    private func setupViews() {
        addSubviews([avatarImageView, labelsStackView, bellImageView])
        labelsStackView.addArrangedSubviews([fullNameLabel, nicknameLabel])
    }
    
    private func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.size.equalTo(45)
        }
        labelsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(avatarImageView.snp.trailing).offset(12)
        }
        bellImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
            make.width.equalTo(22)
            make.height.equalTo(25)
        }
    }
    
    func configure(fullName: String, nickname: String, avatarUrl: String?) {
        fullNameLabel.text = fullName
        nicknameLabel.text = nickname
        if let avatarUrl = URL(string: avatarUrl ?? "") {
            avatarImageView.kf.setImage(with: avatarUrl)
        }
    }
    
    @objc func notificationsTapped() {
        delegate?.notificationsTapped()
    }
    
    @objc func profileTapped() {
        delegate?.profileTapped()
    }
}
