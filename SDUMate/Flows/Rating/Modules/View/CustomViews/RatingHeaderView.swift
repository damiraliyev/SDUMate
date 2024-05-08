//
//  RatingHeaderView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 16.04.2024.
//

import UIKit

final class RatingHeaderView: UIView {
    
    let goldContributor = TopContributorView(type: .gold)
    let silverContributor = TopContributorView(type: .silver)
    let bronzeContributor = TopContributorView(type: .bronze)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = ._110F2F
        addSubviews([silverContributor, goldContributor, bronzeContributor])
        silverContributor.hideCrown()
        bronzeContributor.hideCrown()
    }
    
    private func setupConstraints() {
        let width: CGFloat = (UIView.screenWidth - 32) / 3
        silverContributor.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(186)
        }
        goldContributor.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(silverContributor.snp.trailing)
            make.width.equalTo(width)
        }
        bronzeContributor.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(178)
        }
    }

}
