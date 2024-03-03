//
//  AccountChoiceViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import UIKit
import PanModal

protocol IAccountChoiceView: Presentable {
    var presenter: IAccountChoicePresenter? { get set }
}

final class AccountChoiceViewController: BaseViewController {
    
    var presenter: IAccountChoicePresenter?
    
    private let typeOfAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .dark
        label.font = .bold22
        label.text = "What type of account would you like to create?"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 9
        return stackView
    }()
    
    private lazy var studentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .background
        button.setTitle("Student", for: .normal)
        button.titleLabel?.font = .semibold15
        button.addTarget(self, action: #selector(studentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var alumniButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Alumni", for: .normal)
        button.titleLabel?.font = .semibold15
        button.setTitleColor(.textFieldInner, for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.background.cgColor
        button.addTarget(self, action: #selector(alumniTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        studentButton.layer.cornerRadius = 8
        alumniButton.layer.cornerRadius = 8
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubviews([typeOfAccountLabel, buttonsStackView])
        buttonsStackView.addArrangedSubviews([studentButton, alumniButton])
    }
    
    private func setupConstraints() {
        typeOfAccountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(typeOfAccountLabel.snp.bottom).offset(45)
            make.leading.trailing.equalToSuperview().inset(26)
        }
        studentButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        alumniButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
    }
    
    @objc func studentTapped() {
        presenter?.studentTapped()
    }
    
    @objc func alumniTapped() {
        presenter?.alumniTapped()
    }
}

extension AccountChoiceViewController: PanModalPresentable {
    var panScrollable: UIScrollView? { nil }
    
    var cornerRadius: CGFloat { 16 }
    
    var shouldRoundTopCorners: Bool { true }
    
    var topOffset: CGFloat { .zero }
    
    var showDragIndicator: Bool { true }
    
    var allowsDragToDismiss: Bool { true }
    
    var isHapticFeedbackEnabled: Bool { false }
    
    var panModalBackgroundColor: UIColor { .dark.withAlphaComponent(0.4) }
    
    var longFormHeight: PanModalHeight {
        .contentHeight(313)
    }
}
