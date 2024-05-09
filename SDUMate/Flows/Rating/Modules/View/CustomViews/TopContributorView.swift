//
//  TopContributorView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 16.04.2024.
//

import UIKit
import Kingfisher

enum TopContributorType {
    case gold
    case silver
    case bronze
    case normal
    
    var borderImage: UIImage? {
        switch self {
        case .gold:   return Asset.icGoldBorder.image
        case .silver: return Asset.icSilverBorder.image
        case .bronze: return Asset.icBronzeBorder.image
        case .normal: return nil
        }
    }
    
    var trophyImage: UIImage? {
        switch self {
        case .gold:   return Asset.icTrophyGold.image
        case .silver: return Asset.icTrophySilver.image
        case .bronze:  return Asset.icTrophyBronze.image
        case .normal: return nil
        }
    }
    
    var numerationColor: UIColor {
        switch self {
        case .gold:   return UIColor.gold
        case .silver: return UIColor.silver
        case .bronze: return UIColor.bronze
        case .normal: return .white
        }
    }
}

final class TopContributorView: UIView {
    
    private let type: TopContributorType
    
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
    
    private let borderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icGoldBorder.image
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
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold16
        label.text = "5.0"
        return label
    }()
    
    init(type: TopContributorType) {
        self.type = type
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        borderImageView.layer.cornerRadius = profileImageView.frame.height / 2
        pedestalView.layer.borderColor = UIColor.lightGray.cgColor
        pedestalView.layer.borderWidth = 0.5
    }
    
    private func setupViews() {
        backgroundColor = .clear
        addSubviews([crownImageView, pedestalView, profileImageView, borderImageView, trophyImageView, labelsStackView])
        labelsStackView.addArrangedSubviews([fullNameLabel, pointsLabel])
        trophyImageView.image = type.trophyImage
        borderImageView.image = type.borderImage
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
        borderImageView.snp.makeConstraints { make in
            make.center.equalTo(profileImageView)
            make.size.equalTo(72)
        }
        trophyImageView.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageView)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(2)
            make.size.equalTo(20)
        }
        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(4).priority(.high)
        }
        pedestalView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func hideCrown() {
        crownImageView.safeHide()
    }
    
    func configure(user: DBUser) {
        guard let url = URL(string: user.profileImageUrl ?? "") else { return }
        profileImageView.kf.setImage(with: url, placeholder: Asset.icAvatarPlaceholder.image)
        fullNameLabel.text = "\(user.name ?? "") \(user.surname ?? "")"
        pointsLabel.text = user.points.description + " pt"
    }
}
