//
//  EditProfileCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import UIKit

struct EditProfileCellViewModel {
    let title: String
    let value: String
}

final class EditProfileCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular16
        label.text = "Telegram"
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tabItem
        label.font = .regular16
        label.text = "mntn7"
        label.textAlignment = .right
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.icArrowRightGray.image
        view.contentMode = .scaleAspectFit
        return view
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
        separatorInset.right = 15
        contentView.layer.cornerRadius = 12
        contentView.addSubviews([titleLabel, valueLabel, arrowImageView])
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(snp.centerX)
            make.trailing.equalTo(arrowImageView.snp.leading).offset(-5.5)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.size.equalTo(30)
        }
    }
    
    func configure(with viewModel: EditProfileCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
