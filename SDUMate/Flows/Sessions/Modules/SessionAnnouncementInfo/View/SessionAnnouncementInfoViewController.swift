//
//  SessionAnnouncementInfoViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.04.2024.
//

import UIKit
import PanModal

protocol ISessionAnnouncementInfoView: Presentable {
    var presenter: ISessionAnnouncementInfoPresenter? { get set }
}

final class SessionAnnouncementInfoViewController: BaseViewController, ISessionAnnouncementInfoView {
    
    var presenter: ISessionAnnouncementInfoPresenter?
    private let announcement: Announcement
    private let announcer: DBUser
    private let respondent: DBUser
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold20
        label.text = "Software Engineering"
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold40
        label.text = "1550 ₸"
        return label
    }()
    
    private let categoryDescriptionView = DescriptionView(title: "Category", description: "Math")
    
    private let typeDescriptionView = DescriptionView(title: "Type", description: "Request")
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular20
        label.text = "Description"
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = ._767680.withAlphaComponent(0.2)
        textView.text = "Description"
        textView.textColor = .white
        textView.font = .regular16
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 0)
        return textView
    }()
    
    init(announcement: Announcement, announcer: DBUser, respondent: DBUser) {
        self.announcement = announcement
        self.announcer = announcer
        self.respondent = respondent
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._2A2848
        view.addSubviews([titleLabel, priceLabel, categoryDescriptionView, typeDescriptionView, descriptionLabel, descriptionTextView])
        configure(with: announcement)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(24)
        }
        categoryDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(21)
            make.leading.equalToSuperview().inset(24)
            make.trailing.lessThanOrEqualToSuperview().inset(24)
            make.height.equalTo(35)
        }
        typeDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(categoryDescriptionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(24)
            make.trailing.lessThanOrEqualToSuperview().inset(24)
            make.height.equalTo(35)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(typeDescriptionView.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(24)
        }
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(135)
        }
    }
    
    func configure(with announcement: Announcement) {
        guard let id = AuthManager.shared.getAuthUser()?.uid else { return }
        let otherSide: String
        if announcement.announcer?.userId == id {
            otherSide = "\(respondent.name ?? "") \(respondent.surname ?? "")"
        } else {
            otherSide = "\(announcer.name ?? "") \(announcer.surname ?? "")"
        }
        titleLabel.attributedText = configureTitle(category: announcement.category, otherSide: otherSide)
        priceLabel.text = announcement.price
        categoryDescriptionView.set(description: announcement.category)
        typeDescriptionView.set(description: announcement.type.rawValue)
        descriptionTextView.text = announcement.description
    }
    
    private func configureTitle(category: String, otherSide: String) -> NSMutableAttributedString {
        let categoryAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.semibold20, .foregroundColor: UIColor.white]
        let otherSideAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.semibold20, .foregroundColor: UIColor.orange]
        let rootString = NSMutableAttributedString(string: category, attributes: categoryAttributes)
        let slashString = NSAttributedString(string: " / ", attributes: categoryAttributes)
        let otherSideString = NSAttributedString(string: otherSide, attributes: otherSideAttributes)
        rootString.append(slashString)
        rootString.append(otherSideString)
        return rootString
    }
}

extension SessionAnnouncementInfoViewController: PanModalPresentable {
    var panScrollable: UIScrollView? { nil }
    
    var cornerRadius: CGFloat { 16 }
    
    var shouldRoundTopCorners: Bool { true }
    
    var topOffset: CGFloat { .zero }
    
    var showDragIndicator: Bool { false }
    
    var allowsDragToDismiss: Bool { true }
    
    var isHapticFeedbackEnabled: Bool { false }
    
    var panModalBackgroundColor: UIColor { .dark.withAlphaComponent(0.4) }
    
    var longFormHeight: PanModalHeight {
        .contentHeight(UIView.screenHeight * 0.8)
    }
}
