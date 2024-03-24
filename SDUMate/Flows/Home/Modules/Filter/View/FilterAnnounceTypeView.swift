//
//  FilterAnnounceTypeView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

final class FilterAnnounceTypeView: UIView {
    private let type: AnnounceType
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular16
        return label
    }()
    
    init(type: AnnounceType) {
        self.type = type
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        typeLabel.text = type.title
        layer.cornerRadius = 5
        backgroundColor = ._282645
        addSubview(typeLabel)
    }
    
    private func setupConstraints() {
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
