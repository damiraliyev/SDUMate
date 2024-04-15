//
//  ProfileUserInfoView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 27.03.2024.
//

import UIKit

final class ProfileUserInfoView: UIView {
    
    private let ratingView = RatingView()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium24
        label.text = "Bekzhan Zhakas"
        return label
    }()
    
    private let nickTgStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular14
        label.text = "bekzhan"
        return label
    }()
    
    private let dotLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular14
        label.text = "•"
        return label
    }()
    
    private let tgTagLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular14
        label.text = "@qzpmpzq"
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = ._767680.withAlphaComponent(0.2)
        layer.cornerRadius = 10
        addSubviews([ratingView, labelsStackView, separatorLineView, studyInfoStackView])
        labelsStackView.addArrangedSubviews([usernameLabel, nickTgStackView])
        nickTgStackView.addArrangedSubviews([nicknameLabel, dotLabel, tgTagLabel])
        studyInfoStackView.addArrangedSubviews([facultyView, studyProgramView, yearOfEnteringView])
    }
    
    private func setupConstraints() {
        ratingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(21)
        }
        labelsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.centerX.equalToSuperview()
        }
        separatorLineView.snp.makeConstraints { make in
            make.top.equalTo(labelsStackView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(15).priority(.high)
            make.height.equalTo(0.5)
        }
        studyInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(separatorLineView.snp.bottom).offset(16)
            make.leading.equalTo(separatorLineView)
            make.trailing.equalTo(separatorLineView)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func configure(with user: DBUser) {
        ratingView.setValue(to: user.rating)
        usernameLabel.text = "\(user.name ?? "") \(user.surname ?? "")"
        nicknameLabel.text = user.nickname ?? ""
        tgTagLabel.text = "@" + (user.telegramTag ?? "")
        facultyView.setDescription(to: user.faculty?.rawValue ?? "")
        studyProgramView.setDescription(to: user.studyProgram?.rawValue ?? "")
        yearOfEnteringView.setDescription(to: "\(user.yearOfEntering ?? 0)")
    }
}
