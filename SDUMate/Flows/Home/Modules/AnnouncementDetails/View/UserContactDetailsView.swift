//
//  UserContactsView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

import UIKit

final class UserContactDetailsView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var phoneNumberView: LabelWithLeftIconView = {
        let view = LabelWithLeftIconView(image: UIImage(systemName: "phone")!, text: "+7-700-233-25-19")
        view.alpha = 0
        return view
    }()
    
    private lazy var telegramTagView: LabelWithLeftIconView = {
        let view = LabelWithLeftIconView(image: UIImage(systemName: "paperplane")!, text: "mntn7")
        view.alpha = 0
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium16
        label.text = "Contact will be shown after you are accepted"
        label.numberOfLines = 0
        label.textAlignment = .center
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
        backgroundColor = ._767680.withAlphaComponent(0.2)
        layer.cornerRadius = 15
        addSubviews([stackView, descriptionLabel])
        stackView.addArrangedSubviews([phoneNumberView, telegramTagView])
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        [phoneNumberView, telegramTagView].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(30)
            }
        }
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    func unhideInfo() {
        phoneNumberView.alpha = 1
        telegramTagView.alpha = 1
        descriptionLabel.safeHide()
    }
}
