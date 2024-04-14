//
//  InvitationCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 22.03.2024.
//

import UIKit

protocol InvitationCellDelegate: AnyObject {
    func profileTapped(responder: DBUser, announcementDescription: String)
    func acceptTapped(invitationId: String)
    func rejectedTapped(invitationId: String)
    func withdrawTapped(invitationId: String)
}

final class InvitationReceivedCell: UICollectionViewCell {
    
    weak var delegate: InvitationCellDelegate?
    
    private var invitationId: String?
    private var invitation: Invitation?
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icProfileLavender.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        imageView.addGestureRecognizer(tapRecognizer)
        return imageView
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold16
        label.text = "Bekzhan Zhakas"
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular16
        label.text = "Swift UI"
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 13
        return stackView
    }()
    
    private lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icAcceptCheckmark.image, for: .normal)
        button.addTarget(self, action: #selector(acceptTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var rejectButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icRejectX.image, for: .normal)
        button.addTarget(self, action: #selector(rejectTapped), for: .touchUpInside)
        return button
    }()
    
    private let acceptanceStatusDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium14
        label.safeHide()
        label.numberOfLines = 0
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        titleLabel.text = nil
        acceptanceStatusDescriptionLabel.text = ""
        labelsStackView.safeShow()
        buttonsStackView.safeShow()
        acceptanceStatusDescriptionLabel.safeHide()
    }
    
    private func setupViews() {
        contentView.backgroundColor = ._282645
        contentView.layer.cornerRadius = 10
        contentView.addSubviews([avatarImageView, labelsStackView, buttonsStackView, acceptanceStatusDescriptionLabel])
        labelsStackView.addArrangedSubviews([nameLabel, titleLabel])
        buttonsStackView.addArrangedSubviews([rejectButton, acceptButton])
    }
    
    private func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(32)
        }
        labelsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(avatarImageView.snp.trailing).offset(11)
            make.trailing.equalTo(buttonsStackView.snp.leading).offset(-12)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-13)
        }
        [rejectButton, acceptButton].forEach {
            $0.snp.makeConstraints { make in
                make.size.equalTo(28)
            }
        }
        acceptanceStatusDescriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func configure(with invitation: Invitation) {
        invitationId = invitation.id
        self.invitation = invitation
        avatarImageView.setImageFrom(url: invitation.respondent?.profileImageUrl ?? "")
        nameLabel.text = "\(invitation.respondent?.name ?? "") \(invitation.respondent?.surname ?? "")"
        titleLabel.text = invitation.announcement?.title
        configureStatusDescription(status: invitation.status)
    }
    
    @objc func profileTapped() {
        guard let respondent = invitation?.respondent else { return }
        delegate?.profileTapped(responder: respondent, announcementDescription: invitation?.announcement?.description ?? "")
    }
    
    @objc func acceptTapped() {
        configureStatusDescription(status: .accepted)
        guard let id = invitationId else { return }
        delegate?.acceptTapped(invitationId: id)
    }
    
    @objc func rejectTapped() {
        configureStatusDescription(status: .rejected)
        guard let id = invitationId else { return }
        delegate?.rejectedTapped(invitationId: id)
    }
    
    private func configureStatusDescription(status: InvitationStatus) {
        switch status {
        case .accepted:
            acceptanceStatusDescriptionLabel.text = (nameLabel.text ?? "") + " has been accepted"
        case .rejected:
            acceptanceStatusDescriptionLabel.text = (nameLabel.text ?? "") + " has been rejected"
        case .pending, .withdrawn:
            return
        }
        labelsStackView.safeHide()
        buttonsStackView.safeHide()
        acceptanceStatusDescriptionLabel.safeShow()
    }
}
