//
//  FreeOnlyView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

final class FreeOnlyView: UIView {
    
    var isSelected = false {
        didSet {
            if isSelected {
                checkboxButton.setImage(Asset.icCheckedBox.image, for: .normal)
            } else {
                checkboxButton.setImage(Asset.icUncheckedBox.image, for: .normal)
            }
        }
    }
    
    private let freeOnlyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular18
        label.text = "Free Only"
        return label
    }()
    
    private lazy var checkboxButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icUncheckedBox.image, for: .normal)
        button.setImage(Asset.icCheckedBox.image, for: .selected)
        button.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
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
        addSubviews([checkboxButton, freeOnlyLabel])
    }
    
    private func setupConstraints() {
        checkboxButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(24)
        }
        freeOnlyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkboxButton)
            make.leading.equalTo(checkboxButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
    }
    
    @objc func checkboxTapped() {
        isSelected = !isSelected
    }
}
