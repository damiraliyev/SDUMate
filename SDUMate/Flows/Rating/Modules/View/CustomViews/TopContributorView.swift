//
//  TopContributorView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 16.04.2024.
//

import UIKit

final class TopContributorView: UIView {
    
    private let crownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icCrown.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icAvatarPlaceholder.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let pedestalView: UIView = {
        let view = UIView()
        view.backgroundColor = ._5F5F84.withAlphaComponent(0.4)
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let trophyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.icTrophyGold.image
        return imageView
    }()
    
    private let stackContainerView = UIView()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium14
        label.text = "Cristiano Ronaldo"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold22
        label.text = "5.0"
        return label
    }()
    
    private let studyProgramLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lavender
        label.font = .medium12
        label.text = "Computer science"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
//        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        setupConstraints()
        pedestalView.layer.borderColor = UIColor.lightGray.cgColor
        pedestalView.layer.borderWidth = 0.5
    }
    
    private func setupViews() {
        backgroundColor = .clear
        addSubviews([crownImageView, pedestalView, profileImageView, trophyImageView, labelsStackView])
        labelsStackView.addArrangedSubviews([fullNameLabel, ratingLabel, studyProgramLabel])
        fullNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        ratingLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        studyProgramLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        fullNameLabel.preferredMaxLayoutWidth = fullNameLabel.frame.size.width
        ratingLabel.preferredMaxLayoutWidth = fullNameLabel.frame.size.width
        studyProgramLabel.preferredMaxLayoutWidth = fullNameLabel.frame.size.width
    }
    
    private func setupConstraints() {
        crownImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(29)
        }
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(crownImageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.size.equalTo(70)
        }
        trophyImageView.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageView)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(2)
            make.size.equalTo(20)
        }
        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(4).priority(.high)
            make.bottom.equalToSuperview().offset(-10).priority(.high)
        }
        pedestalView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(labelsStackView)
        }
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: 120, height: 180)
//    }
}
