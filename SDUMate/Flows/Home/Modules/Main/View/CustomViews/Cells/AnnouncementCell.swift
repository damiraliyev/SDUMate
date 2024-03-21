//
//  AnnouncementCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

final class AnnouncementCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icMath.image
        imageView.backgroundColor = ._323266
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium12
        label.text = "Software engineering"
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold16
        label.text = "Object oriented programming"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular18
        label.text = "Unit Testing, UI Testing, Snapshot testing and many other stuff of mobile Delevelopment."
        label.numberOfLines = 0
        return label
    }()
    
    private let announcerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium18
        label.text = "mntn7"
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular18
        label.text = "5/5"
        return label
    }()
    
    private let reviewsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular14
        label.text = "100"
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
    
    private func setupViews() {
        contentView.backgroundColor = ._282645
        contentView.layer.cornerRadius = 18
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor._cdcdcd.cgColor
        contentView.addSubviews([imageView, categoryLabel, titleLabel, descriptionLabel, announcerLabel, ratingLabel, reviewsCountLabel])
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(26)
            make.width.equalTo(110)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(imageView.snp.trailing).offset(18)
            make.trailing.equalToSuperview().offset(-8)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(announcerLabel.snp.top).offset(-4)
        }
        announcerLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(ratingLabel.snp.top).offset(4)
        }
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-16)
        }
        reviewsCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingLabel)
            make.leading.equalTo(ratingLabel.snp.trailing).offset(6)
        }
    }
}
