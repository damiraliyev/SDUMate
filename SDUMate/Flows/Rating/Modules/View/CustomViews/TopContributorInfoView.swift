//
//  TopContributorInfoView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.05.2024.
//

import UIKit

final class TopContributorInfoView: UIView {
    
    var onCloseTapped: Completion?
    
    private lazy var numerationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold14
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.icAvatarPlaceholder.image
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var borderImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium20
        return label
    }()
    
    private let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .tabItem
        return view
    }()
    
    private let studyInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20.5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let facultyView = ProfileStudyInfoView(title: "Faculty")
    
    private let studyProgramView = ProfileStudyInfoView(title: "Profession")
    
    private let yearOfEnteringView = ProfileStudyInfoView(title: "Year of entering")
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icXCloseBold.image, for: .normal)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    private func setupViews() {
        layer.cornerRadius = 10
        backgroundColor = ._2A2848
        addSubviews([numerationLabel, profileImageView, borderImageView, fullNameLabel, separatorLineView, studyInfoStackView, closeButton])
        studyInfoStackView.addArrangedSubviews([facultyView, studyProgramView, yearOfEnteringView])
    }
    
    private func setupConstraints() {
        numerationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(19)
        }
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(numerationLabel)
            make.leading.equalTo(numerationLabel.snp.trailing).offset(18.5)
            make.size.equalTo(61.5)
        }
        profileImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        borderImageView.snp.makeConstraints { make in
            make.center.equalTo(profileImageView)
            make.size.equalTo(63.5)
        }
        fullNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(23)
            make.width.equalTo(200)
        }
        separatorLineView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(19)
            make.height.equalTo(1)
        }
        studyInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(separatorLineView.snp.bottom).offset(16)
            make.leading.equalTo(separatorLineView)
            make.trailing.equalTo(separatorLineView)
            make.bottom.equalToSuperview().offset(-15)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.size.equalTo(20)
        }
    }
    
    func configure(with user: DBUser, type: TopContributorType, place: Int) {
        fullNameLabel.text = "\(user.name ?? "") \(user.surname ?? "")"
        facultyView.setDescription(to: user.faculty?.rawValue ?? "")
        studyProgramView.setDescription(to: user.studyProgram?.rawValue ?? "")
        yearOfEnteringView.setDescription(to: "\(user.yearOfEntering ?? 0)")
        if let url = URL(string: user.profileImageUrl ?? "") {
            profileImageView.kf.setImage(with: url, placeholder: Asset.icAvatarPlaceholder.image)
        }
        numerationLabel.textColor = type.numerationColor
        numerationLabel.text = "0" + place.description
        borderImageView.image = type.borderImage
    }
    
    @objc func closeTapped() {
        onCloseTapped?()
    }
}
