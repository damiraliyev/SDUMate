//
//  DefaultCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 10.03.2024.
//

import UIKit

final class DefaultCell: UITableViewCell {
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .regular14
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
    }
    
    // MARK: - SetupViews
    
    private func setupViews() {
        backgroundColor = .textFieldInner
        contentView.addSubview(titleLabel)
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
