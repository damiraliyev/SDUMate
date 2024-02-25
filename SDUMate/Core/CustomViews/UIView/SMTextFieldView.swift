//
//  SMTextFieldView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 25.02.2024.
//

import UIKit

final class SMTextFieldView: UIView {
    
    private let leftImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews([leftImageView])
    }
    
    private func setupConstraints() {
        leftImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(19.5)
            make.size.equalTo(15)
        }
    }
}
