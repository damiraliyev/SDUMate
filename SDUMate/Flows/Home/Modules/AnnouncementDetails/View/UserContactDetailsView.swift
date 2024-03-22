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
    
    private lazy var phoneNumberView = LabelWithLeftIconView(image: UIImage(systemName: "phone")!, text: "+7-700-233-25-19")
    
    private lazy var telegramTagView = LabelWithLeftIconView(image: UIImage(systemName: "paperplane")!, text: "mntn7")
    
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
        addSubview(stackView)
        stackView.addArrangedSubviews([phoneNumberView, telegramTagView])
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().offset(16)
        }
        [phoneNumberView, telegramTagView].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(30)
            }
        }
    }
}
