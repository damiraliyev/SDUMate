//
//  FormTextFieldView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import UIKit

final class FormTextFieldView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor =  .white
        label.font = .regular13
        return label
    }()
    
    private let fieldView: SMTextFieldView = {
        let fieldView = SMTextFieldView()
        fieldView.layer.cornerRadius = 10
        return fieldView
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
        addSubviews([titleLabel, fieldView])
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        fieldView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(52)
        }
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    func set(placeholderText: String, textColor: UIColor = .lavender.withAlphaComponent(0.4)) {
        fieldView.setPlaceholderText(text: placeholderText, textColor: textColor)
    }
    
    func set(leftImage: UIImage) {
        fieldView.setLeftImage(image: leftImage)
    }
    
    func set(rightImage: UIImage) {
        fieldView.addRightImageView(image: rightImage)
    }
}
