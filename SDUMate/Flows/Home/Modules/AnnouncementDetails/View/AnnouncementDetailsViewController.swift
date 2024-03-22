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
    
    private lazy var navigationBar = SMNavigationBar(title: "") { [weak presenter] in
        presenter?.backTapped()
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.showsVerticalScrollIndicator = false
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
    
    private let descriptionView = AnnounceDesciptionView()
    
    private let studyInfoDetailsView = StudyInfoDetailsView()
    
    private let userContactDetailsView = UserContactDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([scrollView, navigationBar])
        scrollView.addSubview(containerView)
        containerView.addSubviews([imageView, labelsStackView, descriptionView, studyInfoDetailsView, userContactDetailsView])
        labelsStackView.addArrangedSubviews([titleLabel, announcerLabel])
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
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
