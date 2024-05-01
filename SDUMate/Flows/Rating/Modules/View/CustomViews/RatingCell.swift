//
//  RatingCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 28.04.2024.
//

import UIKit

final class RatingCell: UITableView {
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold14
        label.text = "01"
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
    
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
