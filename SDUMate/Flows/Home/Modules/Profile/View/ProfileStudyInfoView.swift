//
//  ProfileStudyInfoView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 27.03.2024.
//

import UIKit

final class ProfileStudyInfoView: UIView {
    
    private let title: String
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tabItem
        label.font = .medium12
        label.text = title
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold14
        label.text = "Engineering and Natural Science"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        self.title = ""
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        addSubviews([titleLabel, descriptionLabel])
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4.8)
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func setDescription(to description: String) {
        descriptionLabel.text = description
    }
}


