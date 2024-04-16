//
//  TopContributorView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 16.04.2024.
//

import UIKit

final class TopContributorView: UIView {
    
    private let crownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icCrown.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let trophyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.icTrophyGold.image
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium16
        label.text = "Name Surname"
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold22
        label.text = "5.0"
        return label
    }()
    
    private let studyProgramLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lavender
        label.font = .medium10
        label.text = "Computer science"
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
    
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
