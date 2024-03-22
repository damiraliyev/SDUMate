//
//  CategoryFilterCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

final class CategoryFilterCell: UITableViewCell {
    
    private let containerView = UIView()
    
    private let checkboxButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icUncheckedBox.image, for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular16
        label.text = "Software engineering"
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
        contentView.backgroundColor = .background
//        contentView.addSubviews([containerView])
        contentView.addSubviews([checkboxButton, titleLabel])
    }
    
    private func setupConstraints() {
        checkboxButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(24)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkboxButton)
            make.leading.equalTo(checkboxButton.snp.trailing).offset(10)
        }
    }
    
    func configure(with category: CategoryFilter) {
        category.isChosen ? checkboxButton.setImage(Asset.icCheckedBox.image, for: .normal) : checkboxButton.setImage(Asset.icUncheckedBox.image, for: .normal)
        titleLabel.text = category.name
    }
}
