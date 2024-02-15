//
//  SuccessAlertViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import UIKit

final class SuccessAlertController: UIViewController {
    
    // MARK: - Properties
    
    private let message: String
    var actionHandler: (() -> Void)?
    
    // MARK: - UI
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let checkmarkImageView = UIImageView(image: UIImage(systemName: "checkmark"))
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .medium12
        label.text = message
        label.textAlignment = .center
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .bpBorderColor
        return view
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle(CoreL10n.ok, for: .normal)
        button.titleLabel?.font = .medium16
        button.setTitleColor(.successOkGreen, for: .normal)
        button.addTarget(self, action: #selector(okPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    
    init(message: String, actionHandler: (() -> Void)? = nil) {
        self.message = message
        self.actionHandler = actionHandler
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
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
        view.backgroundColor = .clear
        view.addSubview(backgroundView)
        view.addSubview(contentView)
        [checkmarkImageView, messageLabel, separatorView, okButton].forEach {
            contentView.addSubview($0)
        }
        backgroundView.alpha = 0
        contentView.alpha = 0
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(240)
            make.height.equalTo(175)
        }
        checkmarkImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(32)
        }
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(checkmarkImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(okButton.snp.top)
            make.height.equalTo(1)
        }
        okButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func appear(_ sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.backgroundView.alpha = 1
            self.contentView.alpha = 1
        } completion: { _ in
            self.actionHandler?()
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    @objc func okPressed() {
        hide()
    }
}

