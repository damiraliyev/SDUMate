//
//  AppliedFilterCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

final class AppliedFilterCell: UICollectionViewCell {
    
    var onRemoveCategoryTapped: Completion?
    var onRemoveTypeTapped: Completion?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular16
        label.text = "Collaborate"
        return label
    }()
    
    private lazy var removeButton: BPPaddingButton = {
        let button = BPPaddingButton(inset: 5)
        button.setImage(Asset.icCloseX.image, for: .normal)
        button.addTarget(self, action: #selector(removeTapped), for: .touchUpInside)
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
    
    func configure(type: AnnounceType) {
        titleLabel.text = type.title
    }
    
    func configure(category: String) {
        titleLabel.text = category
    }
    
    @objc func removeTapped() {
        onRemoveTypeTapped?()
        onRemoveCategoryTapped?()
    }
}
