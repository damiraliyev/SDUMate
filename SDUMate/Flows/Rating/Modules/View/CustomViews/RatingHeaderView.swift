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
        setupConstraintsForBronze()
        setupConstraintsForTop2()
        print("GOLD", goldContributor.frame.height)
    }
    
    private func setupViews() {
        backgroundColor = ._110F2F
        addSubviews([silverContributor, goldContributor, bronzeContributor])
    }
    
    private func setupConstraintsForBronze() {
        let width = frame.width / 3
        bronzeContributor.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(width)
            make.height.greaterThanOrEqualTo(182)
        }
    }
    
    private func setupConstraintsForTop2() {
        let width = frame.width / 3
        silverContributor.snp.remakeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(width)
            make.height.greaterThanOrEqualTo(bronzeContributor.snp.height).offset(15)
        }
        goldContributor.snp.remakeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalTo(silverContributor.snp.trailing)
            make.width.equalTo(width)
            make.height.equalTo(silverContributor.snp.height).offset(15)
        }
    }
    
    func getHeight() -> CGFloat {
        return goldContributor.frame.height
    }
}
