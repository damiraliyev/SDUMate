//
//  FeedbackCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.04.2024.
//

import UIKit

final class FeedbackCell: UITableViewCell {
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium16
        label.text = "Mark Tom"
        return label
    }()
    
    private let starsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3.5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lavender
        label.font = .regular14
        label.text = "2 days ago"
        return label
    }()
    
    private let feedBackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular14
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sed nibh id neque mollis rhoncus eu et urna. Etiam quam enim, dictum eu posuere et, consectetur in nibh."
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = ._110F2F
        selectionStyle = .none
        addSubviews([fullNameLabel, starsStackView, dateLabel, feedBackLabel])
    }
    
    private func setupConstraints() {
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        starsStackView.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.width.greaterThanOrEqualTo(110)
        }
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starsStackView)
            make.leading.equalTo(starsStackView.snp.trailing).offset(15)
        }
        feedBackLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(with feedback: Feedback) {
        fullNameLabel.text = "\(feedback.reviewer?.name ?? "") \(feedback.reviewer?.surname ?? "")"
        configureStars(starRating: feedback.rating)
        dateLabel.text = feedback.createdDate?.changeDateFormat(from: "YYYY-MM-DD'T'HH:mm:SSZ", to: "YYYY.MM.DD")
        feedBackLabel.text = feedback.description
    }
    
    func configureStars(starRating: CGFloat) {
        for num in stride(from: 0, to: starRating, by: 1) {
            let starImageView = UIImageView()
            starImageView.image = Asset.icStar.image
            starImageView.contentMode = .scaleAspectFit
            starImageView.snp.makeConstraints { make in
                make.height.equalTo(16)
            }
            starsStackView.addArrangedSubview(starImageView)
        }
    }
}
