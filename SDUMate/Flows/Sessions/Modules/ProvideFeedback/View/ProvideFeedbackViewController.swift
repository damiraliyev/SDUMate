//
//  ProvideFeedbackViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 12.04.2024.
//

import UIKit
import PanModal

protocol IProvideFeedbackView: Presentable {
    var presenter: IProvideFeedbackPresenter? { get set }
}

final class ProvideFeedbackViewController: BaseViewController, IProvideFeedbackView {
    
    var presenter: IProvideFeedbackPresenter?
    
    private let sessionEndedLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._F5F5F5
        label.font = .regular20
        label.text = "Session ended"
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.icDoubleAcceptance.image
        return imageView
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold24
        label.text = "Mock full name"
        return label
    }()
    
    private let announcementTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold18
        label.text = "Mock text"
        label.numberOfLines = 0
        return label
    }()
    
    private let starsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 13
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let howEverythingGoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .regular18
        label.text = "How did everything go?"
        return label
    }()
    
    private lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = ._767680.withAlphaComponent(0.2)
        textView.text = "Your comment..."
        textView.textColor = ._cdcdcd
        textView.font = .regular16
        textView.layer.cornerRadius = 10
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 0)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._2A2848
        view.addSubviews([sessionEndedLabel, avatarImageView, labelsStackView, starsStackView, howEverythingGoLabel, commentTextView])
        labelsStackView.addArrangedSubviews([fullNameLabel, announcementTitleLabel])
        configureStars()
    }
    
    private func setupConstraints() {
        sessionEndedLabel.snp.makeConstraints { make in
            make.top.equalTo(37)
            make.centerX.equalToSuperview()
        }
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(sessionEndedLabel.snp.bottom).offset(36)
            make.leading.equalToSuperview().offset(37)
            make.size.equalTo(85)
        }
        labelsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(21)
            make.trailing.equalToSuperview().offset(-24)
        }
        starsStackView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(25)
            make.leading.equalTo(avatarImageView)
            make.trailing.equalToSuperview().offset(-36)
            make.height.equalTo(60)
        }
        howEverythingGoLabel.snp.makeConstraints { make in
            make.top.equalTo(starsStackView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(36)
        }
        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(howEverythingGoLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(105)
        }
    }
    
    private func configureStars() {
        for i in 0..<5 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = Asset.icStarEmptyGold.image
            starsStackView.addArrangedSubview(imageView)
        }
    }
}

extension ProvideFeedbackViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == ._cdcdcd {
            textView.text = nil
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Your comment..."
            textView.textColor = ._cdcdcd
        }
    }
}


extension ProvideFeedbackViewController: PanModalPresentable {
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
