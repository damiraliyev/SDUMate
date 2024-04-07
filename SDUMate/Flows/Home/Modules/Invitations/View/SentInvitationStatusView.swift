//
//  SentInvitationStatusView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 07.04.2024.
//

import UIKit

final class SentInvitationStatusView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lavender
        label.font = .regular12
        label.text = "Pending"
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
        backgroundColor = .clear
        addSubviews([imageView, titleLabel])
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(12)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
        }
    }
    
    func configure(status: InvitationStatus) {
        imageView.image = status.image
        titleLabel.text = status.rawValue.capitalized
    }
}
