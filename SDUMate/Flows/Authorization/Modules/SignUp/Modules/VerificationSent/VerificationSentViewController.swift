//
//  VerificationSentViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 08.03.2024.
//

import UIKit

protocol VerificationSentViewDelegate: AnyObject {
    func continueTapped()
}

final class VerificationSentViewController: BaseViewController {
    
    weak var delegate: VerificationSentViewDelegate?
    
    private let navigationBar = SMNavigationBar(title: "", tapCallback: nil)
    
    private let envelopeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Asset.icEnvelop3d.image
        return imageView
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .center
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium24
        label.text = "Email has been sent!"
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lavender
        label.font = .medium16
        label.text = "Please, check your inbox and follow verify your email"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var continueButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .medium16
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        self.view = AuthView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubviews([navigationBar, envelopeImageView, labelsStackView, continueButton])
        labelsStackView.addArrangedSubviews([titleLabel, descriptionLabel])
    }
    
    private func setupConstraints() {
        labelsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        envelopeImageView.snp.makeConstraints { make in
            make.bottom.equalTo(labelsStackView.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.size.equalTo(138)
        }
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(labelsStackView.snp.bottom).offset(38)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
    }
    
    @objc func continueTapped() {
        delegate?.continueTapped()
    }
}
