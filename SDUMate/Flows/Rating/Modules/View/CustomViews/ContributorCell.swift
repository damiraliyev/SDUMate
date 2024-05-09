//
//  ContributorCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 08.05.2024.
//

import UIKit
import Kingfisher

final class ContributorCell: UICollectionViewCell {
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold14
        label.text = "04"
        label.isSkeletonable = true
        label.skeletonCornerRadius = 4
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Asset.icAvatarPlaceholder.image
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.isSkeletonable = true
        return stackView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium16
        label.text = "Gary Sanford"
        label.isSkeletonable = true
        label.skeletonCornerRadius = 4
        return label
    }()
    
    private lazy var facultyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lavender
        label.font = .medium12
        label.numberOfLines = 2
        label.text = "Faculty of engineering and natural sciences"
        label.isSkeletonable = true
        label.skeletonCornerRadius = 4
        return label
    }()
    
    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold20
        label.text = "100"
        label.isSkeletonable = true
        label.skeletonCornerRadius = 4
        return label
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
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        }
    }
    
    private func setupViews() {
        backgroundColor = ._767680.withAlphaComponent(0.2)
        contentView.addSubviews([numberLabel, profileImageView, labelsStackView, pointsLabel])
        layer.cornerRadius = 15
        isSkeletonable = true
        contentView.isSkeletonable = true
        contentView.layer.cornerRadius = 15
        labelsStackView.addArrangedSubviews([fullNameLabel, facultyLabel])
    }
    
    private func setupConstraints() {
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(numberLabel.snp.trailing).offset(10.5)
            make.size.equalTo(55)
        }
        labelsStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(9.5)
            make.leading.equalTo(profileImageView.snp.trailing).offset(11)
            make.width.lessThanOrEqualTo(190)
        }
        pointsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        pointsLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func configure(with user: DBUser, place: Int) {
        var place = place < 10 ? "0" + place.description : place.description
        numberLabel.text = place
        fullNameLabel.text = "\(user.name ?? "") \(user.surname ?? "")"
        facultyLabel.text = user.faculty?.rawValue ?? ""
        pointsLabel.text = user.points.description
        if let url = URL(string: user.profileImageUrl ?? "") {
            profileImageView.kf.setImage(with: url, placeholder: Asset.icAvatarPlaceholder.image)
        }
    }
}
