//
//  ProfileFooterView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import UIKit

protocol ProfileFooterDelegate: AnyObject {
    func logOutTapped()
}

final class ProfileFooterView: UIView {
    
    weak var delegate: ProfileFooterDelegate?
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = ._767680.withAlphaComponent(0.2)
        button.layer.cornerRadius = 12
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(._FF453A, for: .normal)
        button.tintColor = ._FF453A
        button.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
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
        layer.cornerRadius = 12
        backgroundColor = .clear
        addSubview(logOutButton)
    }
    
    private func setupConstraints() {
        logOutButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16).priority(.high)
        }
    }
    
    @objc func logOutTapped() {
        delegate?.logOutTapped()
    }
}
