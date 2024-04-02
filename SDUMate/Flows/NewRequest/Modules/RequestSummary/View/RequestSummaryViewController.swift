//
//  RequestSummaryViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 01.04.2024.
//

import UIKit

protocol IRequestSummaryView: Presentable {
    var presenter: IRequestSummaryPresenter? { get set }
}

final class RequestSummaryViewController: BaseViewController, IRequestSummaryView {
    var presenter: IRequestSummaryPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "Advertise") { [weak presenter] in
        presenter?.backTapped()
    } rightBtnTapCallback: {
        print("CANCEL TAPPED")
    }
    
    private let progressView = ProgressView(iterationsCount: 5)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold20
        label.text = "Software Engineering"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold40
        label.text = "1550 ₸"
        return label
    }()
    
    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
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
        textView.textColor = ._cdcdcd
        textView.font = .regular14
        textView.layer.cornerRadius = 10
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 0)
        return textView
    }()
    
    private lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = ._0A84FF
        button.layer.cornerRadius = 13
        button.addTarget(self, action: #selector(postTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        navigationBar.isRightButtonHidden = false
        navigationBar.rightButtonTitle = "Cancel"
        view.addSubviews([navigationBar, progressView, titleLabel, priceLabel, descriptionStackView, descriptionLabel, descriptionTextView, postButton])
        descriptionStackView.addArrangedSubviews([categoryDescriptionView, typeDescriptionView])
        progressView.color(first: 5)
    }
    
    private func setupConstraints() {
        progressView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(23)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(3)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(24)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(24)
        }
        descriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(21)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(35)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionStackView.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(24)
        }
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(135)
        }
        postButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-32)
            make.height.equalTo(48)
        }
    }
    
    @objc func postTapped() {
        presenter?.postTapped()
    }
}

extension RequestSummaryViewController: UITextViewDelegate {
    
}
