//
//  PriceSetupViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 01.04.2024.
//

import UIKit

protocol IPriceSetupView: Presentable {
    var presenter: IPriceSetupPresenter? { get set }
}

final class PriceSetupViewController: BaseViewController, IPriceSetupView {
    var presenter: IPriceSetupPresenter?
    
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
        label.text = "Specify the price"
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Price", "Free", "Negotiable"])
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = ._222294
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, .font: UIFont.medium16]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = ._0A84FF
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.layer.cornerRadius = 6
        return segmentedControl
    }()
    
    private let textField: EditTextFieldView = {
        let textField = EditTextFieldView()
        textField.setPlaceholderText(text: "Price")
        textField.backgroundColor = ._767680.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = ._0A84FF
        button.layer.cornerRadius = 13
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
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
        view.addSubviews([navigationBar, progressView, titleLabel, textField, segmentedControl, continueButton])
        progressView.color(first: 4)
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
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(45)
        }
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-32)
            make.height.equalTo(48)
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 || sender.selectedSegmentIndex == 2 {
            textField.safeHide()
        } else {
            textField.safeShow()
        }
    }
    
    @objc func continueTapped() {
        presenter?.continueTapped(price: textField.getText() ?? "", conditionIndex: segmentedControl.selectedSegmentIndex)
    }
}
