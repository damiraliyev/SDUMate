//
//  ProfileCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 27.03.2024.
//

import UIKit

final class ProfileCell: UITableViewCell {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular16
        label.text = "Reviews"
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icArrowRight.image
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        backgroundColor = ._767680.withAlphaComponent(0.2)
        layer.cornerRadius = 12
        selectionStyle = .none
        contentView.addSubviews([iconImageView, titleLabel, arrowImageView])
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(15)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
            make.width.equalTo(9)
            make.height.equalTo(15)
        }
    }
    
    func configure(with sectionType: ProfileItemType) {
        iconImageView.image = sectionType.image
        titleLabel.text = sectionType.title
    }
}
