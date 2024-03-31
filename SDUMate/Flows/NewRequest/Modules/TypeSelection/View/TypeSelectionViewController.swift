//
//  TypeSelectionViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 31.03.2024.
//

import UIKit
import SkyFloatingLabelTextField

protocol ITypeSelectionView: Presentable {
    var presenter: ITypeSelectionPresenter? { get set }
}

final class TypeSelectionViewController: BaseViewController, ITypeSelectionView {
    
    var presenter: ITypeSelectionPresenter?
    
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
        label.text = "Come up with a name"
        return label
    }()
    
    private let textField: EditTextFieldView = {
        let textField = EditTextFieldView()
        textField.setPlaceholderText(text: "Write title")
        textField.backgroundColor = ._767680.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private let selectLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold20
        label.text = "Select announcement type"
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Offer", "Request", "Collaborate"])
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
        view.addSubviews([navigationBar, progressView, titleLabel, textField, selectLabel, segmentedControl, continueButton])
        progressView.color(first: 1)
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
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(45)
        }
        selectLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(24)
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(selectLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-32)
            make.height.equalTo(48)
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
    }
    
    @objc func continueTapped() {
        presenter?.continueTapped()
    }
}
