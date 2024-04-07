//
//  InvitationSentCell.swift
//  SDUMate
//
//  Created by Damir Aliyev on 07.04.2024.
//

import UIKit

final class InvitationSentCell: UICollectionViewCell {
    
    private var invitationId: String?
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icProfileLavender.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
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
    
    private let statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let statusView = SentInvitationStatusView()
    
    private let statusDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .medium16
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
    }
    
    private func setupViews() {
        contentView.backgroundColor = ._282645
        contentView.layer.cornerRadius = 10
        contentView.addSubviews([avatarImageView, labelsStackView, statusStackView])
        labelsStackView.addArrangedSubviews([nameLabel, titleLabel])
        statusStackView.addArrangedSubviews([statusView, statusDescriptionLabel])
    }
    
    private func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(24)
        }
        labelsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(avatarImageView.snp.trailing).offset(11)
            make.width.lessThanOrEqualTo(250)
        }
        statusStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        statusView.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
    }
    
    func configure(with invitation: Invitation) {
        invitationId = invitation.id
        avatarImageView.setImageFrom(url: invitation.respondent?.profileImageUrl ?? "")
        nameLabel.text = "\(invitation.respondent?.name ?? "") \(invitation.respondent?.surname ?? "")"
        titleLabel.text = invitation.announcement?.title
        statusView.configure(status: invitation.status)
        statusDescriptionLabel.text = invitation.status.description
        statusDescriptionLabel.textColor = invitation.status.descriptionColor
    }
}
