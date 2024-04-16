//
//  RatingHeaderView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 16.04.2024.
//

import UIKit

final class RatingHeaderView: UIView {
    
    let goldContributor = TopContributorView()
    let silverContributor = TopContributorView()
    let bronzeContributor = TopContributorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
//        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    private func setupViews() {
        backgroundColor = ._110F2F
        addSubviews([silverContributor, goldContributor, bronzeContributor])
    }
    
    private func setupConstraints() {
        let width = (frame.width - 16) / 3
        silverContributor.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(153)
        }
        goldContributor.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(silverContributor.snp.trailing)
            make.width.equalTo(width)
        }
        bronzeContributor.snp.makeConstraints { make in
            make.leading.equalTo(goldContributor.snp.trailing)
            make.bottom.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(145)
        }
    }
}
