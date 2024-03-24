//
//  InvitationDateHeaderView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 24.03.2024.
//

import UIKit

final class InvitationDateHeaderView: UICollectionReusableView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ._282645
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lavender
        label.font = .medium14
        label.text = "04 march 2024"
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = containerView.frame.height / 2
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
