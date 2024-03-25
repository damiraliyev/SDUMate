//
//  SessionCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 22.03.2024.
//

import UIKit

final class SessionCell: UICollectionViewCell {
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = .regular20
        label.text = "Request"
        return label
    }()
    
    private let titleAndCategoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold16
        label.text = "Swift UI/Software Engineering"
        return label
    }()
    
    private let recipientLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular16
        label.text = "Bekzhan Zhakas"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular14
        label.text = "14 March"
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = ._164DDC
        button.backgroundColor = .clear
        button.setTitle("Contact", for: .normal)
        button.setTitleColor(._164DDC, for: .normal)
        button.titleLabel?.font = .medium16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor._164DDC.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = ._164DDC
        button.setTitle("More", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .medium16
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let threeDotsButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.ic3Dots.image, for: .normal)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        typeLabel.text = nil
        titleAndCategoryLabel.text = ""
        recipientLabel.text = nil
        dateLabel.text = nil
    }
    
    private func setupViews() {
        contentView.backgroundColor = ._282645
        contentView.layer.cornerRadius = 10
        contentView.addSubviews([typeLabel, threeDotsButton, titleAndCategoryLabel, recipientLabel, dateLabel, buttonsStackView])
        buttonsStackView.addArrangedSubviews([contactButton, moreButton])
    }
    
    private func setupConstraints() {
        typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(12)
        }
        threeDotsButton.snp.makeConstraints { make in
            make.centerY.equalTo(typeLabel)
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(21)
            make.height.equalTo(24)
        }
        titleAndCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        recipientLabel.snp.makeConstraints { make in
            make.top.equalTo(titleAndCategoryLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(12)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(recipientLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(12)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func configure(with announcement: Announcement) {
        typeLabel.text = announcement.type.title
        titleAndCategoryLabel.text = "\(announcement.title)/\(announcement.category)"
        recipientLabel.text = announcement.respondentId
        dateLabel.text = announcement.sessionEstablishedDate
    }
}
