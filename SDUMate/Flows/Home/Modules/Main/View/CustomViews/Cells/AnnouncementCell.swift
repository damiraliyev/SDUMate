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
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold16
        label.text = "Object oriented programming"
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular12
        label.text = "Unit Testing, UI Testing, Snapshot testing and many other stuff of mobile Delevelopment."
        label.numberOfLines = 0
        return label
    }()
    
    private let announcerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium12
        label.text = "mntn7"
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular12
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
    
    private let priceView = PriceView()
    
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
        contentView.addSubviews([imageView, categoryLabel, titleLabel, 
                                 descriptionLabel, announcerLabel, ratingLabel,
                                 reviewsCountLabel, priceView])
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(26)
            make.size.equalTo(80)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(imageView)
            
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(imageView.snp.trailing).offset(18)
            make.trailing.equalToSuperview().offset(-8)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(priceView.snp.top).offset(-12)
        }
        announcerLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(ratingLabel.snp.top).offset(-4)
        }
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-14)
        }
        reviewsCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingLabel)
            make.leading.equalTo(ratingLabel.snp.trailing).offset(6)
        }
        priceView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalTo(-8)
            make.height.equalTo(24)
        }
    }
    
    func configure(with announcement: Announcement) {
        categoryLabel.text = announcement.category
        titleLabel.text = announcement.title
        descriptionLabel.text = announcement.description
        announcerLabel.text = announcement.announcer
        ratingLabel.text = announcement.rating
        reviewsCountLabel.text = "\(announcement.reviewsCount)"
        priceView.setValue(to: announcement.price)
    }
}
