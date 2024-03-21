//
//  PriceView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

final class PriceView: UIView {
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold14
        label.text = "990 ₸"
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
        layer.cornerRadius = frame.height / 2
    }
    
    private func setupViews() {
        layer.borderWidth = 1
        layer.borderColor = UIColor._cdcdcd.cgColor
        backgroundColor = .textFieldInner
        addSubview(priceLabel)
    }
    
    private func setupConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setValue(to value: String) {
        priceLabel.text = value
    }
}
