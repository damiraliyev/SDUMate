//
//  LabelWithLeftIconView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

final class LabelWithLeftIconView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular14
        return label
    }()
    
    init(image: UIImage, text: String) {
        imageView.image = image
        titleLabel.text = text
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews([imageView, titleLabel])
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(30)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
    }
    
    func set(text: String) {
        titleLabel.text = text
    }
}
