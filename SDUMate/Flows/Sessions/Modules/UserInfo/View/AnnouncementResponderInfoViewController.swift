//
//  UserInfoViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.04.2024.
//

import UIKit

protocol IAnnouncementResponderInfoView: Presentable {
    var presenter: IAnnouncementResponderInfoPresenter? { get set }
    
    func configure(with responder: DBUser, announcementDescription: String, feedbacks: [Feedback])
}

final class AnnouncementResponderInfoViewController: BaseViewController, IAnnouncementResponderInfoView {
    
    var presenter: IAnnouncementResponderInfoPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "User info") { [weak presenter] in
        presenter?.backTapped()
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let containerView = UIView()
    
    private let profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.hideChangeButton()
        return view
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = ._767680.withAlphaComponent(0.2)
        textView.text = "Description"
        textView.textColor = .white
        textView.font = .regular16
        textView.layer.cornerRadius = 10
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 0)
        return textView
    }()
    
    private let feedbackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold18
        label.text = "Student feedback"
        return label
    }()
    
    private let feedbacksStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var seeAllLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = .semibold16
        label.text = "See all"
        label.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(seeAllTapped))
        label.addGestureRecognizer(tapRecognizer)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([scrollView, navigationBar])
        scrollView.addSubview(containerView)
        containerView.addSubviews([profileHeaderView, descriptionTextView, feedbackLabel, feedbacksStackView, seeAllLabel])
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        profileHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.leading.trailing.equalToSuperview()
//            make.height.greaterThanOrEqualTo(320)
        }
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom).offset(23)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(135)
        }
        feedbackLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
        }
        feedbacksStackView.snp.makeConstraints { make in
            make.top.equalTo(feedbackLabel.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        seeAllLabel.snp.makeConstraints { make in
            make.top.equalTo(feedbacksStackView.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-28)
        }
    }
    
    private func configure(feedbacks: [Feedback]) {
        guard feedbacks.count > 0 else {
            feedbackLabel.text = "No feedbacks yet"
            feedbacksStackView.safeHide()
            seeAllLabel.safeHide()
            return
        }
        let upperRange = min(feedbacks.count, 2)
        for i in 0..<upperRange {
            let feedbackView = FeedbackView(feedback: feedbacks[i])
            feedbacksStackView.addArrangedSubview(feedbackView)
        }
        if feedbacks.count < 2 {
            seeAllLabel.safeHide()
        } else {
            seeAllLabel.safeShow()
        }
    }
    
    func configure(with responder: DBUser, announcementDescription: String, feedbacks: [Feedback]) {
        profileHeaderView.configure(with: responder)
        view.layoutIfNeeded()
        descriptionTextView.text = announcementDescription
        configure(feedbacks: feedbacks)
    }
    
    @objc func seeAllTapped() {
        presenter?.seeAllTapped()
    }
}
