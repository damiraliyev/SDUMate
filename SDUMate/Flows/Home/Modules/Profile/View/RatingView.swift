//
//  RatingView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 27.03.2024.
//

import UIKit

final class RatingView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    
    private let ratingValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._110F2F
        label.font = .regular14
        label.text = "5.0"
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icStar.image
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        backgroundColor = .white
        layer.cornerRadius = 4
        addSubview(stackView)
        stackView.addArrangedSubviews([ratingValueLabel, starImageView])
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(2)
            make.leading.trailing.equalToSuperview().inset(5)
        }
        starImageView.snp.makeConstraints { make in
            make.width.equalTo(9.5)
        }
    }
    
    func setValue(to value: Double) {
        ratingValueLabel.text = "\(value)"
    }
}

