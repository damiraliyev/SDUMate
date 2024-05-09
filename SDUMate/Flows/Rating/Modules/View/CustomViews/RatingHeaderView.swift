//
//  RatingHeaderView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 16.04.2024.
//

import UIKit

final class RatingHeaderView: UIView {
    
    var contributorTapped: ((_ type: TopContributorType) -> Void)?
    
    let goldContributor = TopContributorView(type: .gold)
    let silverContributor = TopContributorView(type: .silver)
    let bronzeContributor = TopContributorView(type: .bronze)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = ._110F2F
        let views = [silverContributor, goldContributor, bronzeContributor]
        addSubviews(views)
        views.forEach { $0.safeHide() }
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
            make.height.equalTo(182)
        }
    }
    
    private func setupGestureRecognizers() {
        [goldContributor, silverContributor, bronzeContributor].forEach { $0.isUserInteractionEnabled = true }
        let goldRecognizer = UITapGestureRecognizer(target: self, action: #selector(goldTapped))
        goldContributor.addGestureRecognizer(goldRecognizer)
        let silverRecognizer = UITapGestureRecognizer(target: self, action: #selector(silverTapped))
        silverContributor.addGestureRecognizer(silverRecognizer)
        let bronzeRecognizer = UITapGestureRecognizer(target: self, action: #selector(bronzeTapped))
        bronzeContributor.addGestureRecognizer(bronzeRecognizer)
    }
    
    func configure(goldUser: DBUser?, silverUser: DBUser?, bronzeUser: DBUser?) {
        configureGold(goldUser: goldUser)
        configureSilver(silverUser: silverUser)
        configureBronze(bronzeUser: bronzeUser)
    }
    
    private func configureGold(goldUser: DBUser?) {
        guard let goldUser = goldUser else {
            goldContributor.safeHide()
            return
        }
        goldContributor.configure(user: goldUser)
        goldContributor.safeShow()
    }
    
    private func configureSilver(silverUser: DBUser?) {
        guard let silverUser = silverUser else {
            silverContributor.safeHide()
            return
        }
        silverContributor.configure(user: silverUser)
        silverContributor.safeShow()
    }
    private func configureBronze(bronzeUser: DBUser?) {
        guard let bronzeUser = bronzeUser else {
            bronzeContributor.safeHide()
            return
        }
        bronzeContributor.configure(user: bronzeUser)
        bronzeContributor.safeShow()
    }
    
    @objc func goldTapped() {
        contributorTapped?(.gold)
    }
    
    @objc func silverTapped() {
        contributorTapped?(.silver)
    }
    
    @objc func bronzeTapped() {
        contributorTapped?(.bronze)
    }
}
