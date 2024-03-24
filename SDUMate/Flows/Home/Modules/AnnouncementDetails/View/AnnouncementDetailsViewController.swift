//
//  AnnouncementDescriptionViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

protocol IAnnouncementDetailsView: Presentable {
    var presenter: IAnnouncementDetailsPresenter? { get set }
}

final class AnnouncementDetailsViewController: BaseViewController, IAnnouncementDetailsView {
    
    var presenter: IAnnouncementDetailsPresenter?
    private let announcement: Announcement
    
    private lazy var navigationBar = SMNavigationBar(title: "") { [weak presenter] in
        presenter?.onBackTapped?()
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let containerView = UIView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icMath.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold24
        label.text = "Software engineering"
        return label
    }()
    
    private let announcerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = .medium18
        label.text = "Software engineering"
        return label
    }()
    
//    private let typeLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
    
    private let descriptionView = AnnounceDesciptionView()
    
    private let studyInfoDetailsView = StudyInfoDetailsView()
    
    private let userContactDetailsView = UserContactDetailsView()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Send offer", for: .normal)
        button.titleLabel?.font = .medium18
        button.setTitleColor(.dark, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold22
        label.text = "990 ₸"
        return label
    }()
    
    init(announcement: Announcement) {
        self.announcement = announcement
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
        view.backgroundColor = ._110F2F
        view.addSubviews([scrollView, navigationBar])
        scrollView.addSubview(containerView)
        containerView.addSubviews([imageView, labelsStackView, descriptionView, studyInfoDetailsView, userContactDetailsView, priceLabel, sendButton])
        labelsStackView.addArrangedSubviews([titleLabel, announcerLabel])
        configure()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 5.12)
        }
        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(47)
            make.leading.equalToSuperview().offset(16)
        }
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(labelsStackView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        studyInfoDetailsView.snp.makeConstraints { make in
            make.top.equalTo(descriptionView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        userContactDetailsView.snp.makeConstraints { make in
            make.top.equalTo(studyInfoDetailsView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(userContactDetailsView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
        }
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }
    }
    
    private func configure() {
        titleLabel.text = announcement.title
        announcerLabel.text = announcement.announcer
        descriptionView.set(text: announcement.description)
        priceLabel.text = announcement.price
    }
}
