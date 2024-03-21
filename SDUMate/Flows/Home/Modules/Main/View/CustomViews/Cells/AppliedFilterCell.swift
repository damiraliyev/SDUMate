//
//  AppliedFilterCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

final class AppliedFilterCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular16
        label.text = "Collaborate"
        return label
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icCloseX.image, for: .normal)
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
    
    private func setupViews() {
        contentView.backgroundColor = ._282645
        contentView.layer.cornerRadius = 7
        contentView.addSubviews([titleLabel, removeButton])
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(7.5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(removeButton.snp.leading).offset(-10)
        }
        removeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.size.equalTo(9)
        }
    }
}
