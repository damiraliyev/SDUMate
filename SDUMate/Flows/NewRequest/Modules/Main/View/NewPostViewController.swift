//
//  NewRequestViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

protocol INewPostView: Presentable {
    var presenter: INewPostPresenter? { get set }
}

final class NewPostViewController: BaseViewController, INewPostView {
    
    var presenter: INewPostPresenter?
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium24
        label.text = "Post your need"
        return label
    }()
    
    private let optionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private let createRequestView = PostOptionsView()
    private let createOfferView = PostOptionsView()
    private let collaborateView = PostOptionsView()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create a post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ._0A84FF
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([postLabel, optionsStackView, createButton])
        optionsStackView.addArrangedSubviews([createRequestView, createOfferView, collaborateView])
        createRequestView.configure(image: Asset.icCreateRequest.image, title: "Create a request", description: "Seek guidance on personal growth in fields like Software development and beyond.")
        createOfferView.configure(image: Asset.icCreateOffer.image, title: "Create an offer", description: "Share knowledge in some are like Software Development, Design, Art or other for free or for price.")
        collaborateView.configure(image: Asset.icCollaborate.image, title: "Collaborate", description: "Collaborate with other students to gain knowlegde together.")
    }
    
    private func setupConstraints() {
        postLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(48)
            make.centerX.equalToSuperview()
        }
        optionsStackView.snp.makeConstraints { make in
            make.top.equalTo(postLabel.snp.bottom).offset(36)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        createButton.snp.makeConstraints { make in
            make.top.equalTo(optionsStackView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
    }
    
    @objc func startTapped() {
        presenter?.startTapped()
    }
}
