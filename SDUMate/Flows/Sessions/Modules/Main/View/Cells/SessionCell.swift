//
//  SessionCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 22.03.2024.
//

import UIKit

protocol SessionCellDelegate: AnyObject {
    func contactTapped(otherSide: DBUser, announcementDescription: String)
    func moreTapped(session: Session)
    func threeDotsTapped(session: Session)
}

final class SessionCell: UICollectionViewCell {
    
    weak var delegate: SessionCellDelegate?
    
    private var session: Session?
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = .regular20
        label.text = "Request"
        return label
    }()
    
    private let titleAndCategoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold16
        label.text = "Swift UI/Software Engineering"
        label.numberOfLines = 2
        return label
    }()
    
    private let recipientLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular16
        label.text = "Bekzhan Zhakas"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular14
        label.text = "14 March"
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = ._164DDC
        button.backgroundColor = .clear
        button.setTitle("Contact", for: .normal)
        button.setTitleColor(._164DDC, for: .normal)
        button.titleLabel?.font = .medium16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor._164DDC.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(contactTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = ._164DDC
        button.setTitle("More", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .medium16
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var threeDotsButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.ic3Dots.image, for: .normal)
        button.addTarget(self, action: #selector(threeDotsTapped), for: .touchUpInside)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        typeLabel.text = nil
        titleAndCategoryLabel.text = ""
        recipientLabel.text = nil
        dateLabel.text = nil
        session = nil
    }
    
    private func setupViews() {
        contentView.backgroundColor = ._282645
        contentView.layer.cornerRadius = 10
        contentView.addSubviews([typeLabel, threeDotsButton, titleAndCategoryLabel, recipientLabel, dateLabel, buttonsStackView])
        buttonsStackView.addArrangedSubviews([contactButton, moreButton])
    }
    
    private func setupConstraints() {
        typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(26)
        }
        threeDotsButton.snp.makeConstraints { make in
            make.centerY.equalTo(typeLabel)
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(21)
            make.height.equalTo(24)
        }
        titleAndCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        titleAndCategoryLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        recipientLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.bottom.equalTo(dateLabel.snp.top).offset(-5)
            make.height.equalTo(15)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.bottom.equalTo(buttonsStackView.snp.top).offset(-5)
            make.height.equalTo(18)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-15)
            make.height.equalTo(42)
        }
    }
    
    func configure(with session: Session) {
        guard let id = AuthManager.shared.getAuthUser()?.uid else { return }
        self.session = session
        configureType(for: session)
        titleAndCategoryLabel.text = "\(session.announcement?.title ?? "")/\(session.announcement?.category ?? "")"
        if session.respondentId == id {
            recipientLabel.text = "Announcer: \(session.announcer?.name ?? "") \(session.announcer?.surname ?? "")"
        } else {
            recipientLabel.text = "Respondent: \(session.respondent?.name ?? "") \(session.respondent?.surname ?? "")"
        }
        dateLabel.text = session.createdDate?.convertDateToString()
    }
    
    private func configureType(for session: Session) {
        guard let id = AuthManager.shared.getAuthUser()?.uid else { return }
        if id == session.announcerId && session.announceType == .offer {
            typeLabel.text = "Offer"
        } else if id == session.respondentId && session.announceType == .offer {
            typeLabel.text = "Request"
        } else if id == session.announcerId && session.announceType == .request {
            typeLabel.text = "Request"
        } else if id == session.respondentId && session.announceType == .request {
            typeLabel.text = "Offer"
        } else if session.announceType == .collaborate {
            typeLabel.text = "Collaborate"
        }
    }
    
    @objc func contactTapped() {
        guard let session = session,
              let id = AuthManager.shared.getAuthUser()?.uid,
              let announcer = session.announcer,
              let respondent = session.respondent else {
            return
        }
        let otherSide: DBUser
        if id == session.respondentId {
            otherSide = announcer
        } else {
            otherSide = respondent
        }
        delegate?.contactTapped(otherSide: otherSide, announcementDescription: session.announcement?.description ?? "")
    }
    
    @objc func moreTapped() {
        guard let session = session else { return }
        delegate?.moreTapped(session: session)
    }
    
    @objc func threeDotsTapped() {
        guard let session = session else { return }
        delegate?.threeDotsTapped(session: session)
    }
}
