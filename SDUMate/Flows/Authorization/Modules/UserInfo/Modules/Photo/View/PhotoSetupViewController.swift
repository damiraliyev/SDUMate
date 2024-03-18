//
//  PhotoSetupViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import UIKit

protocol IPhotoSetupView: Presentable {
    var presenter: IPhotoSetupPresenter? { get set }
    
    func set(image: UIImage)
    func changeAddPhotoTitle()
}

final class PhotoSetupViewController: BaseViewController, IPhotoSetupView {
    
    var presenter: IPhotoSetupPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "Photo") { [weak presenter] in
        presenter?.backTapped()
    }
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let tipLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lavender
        label.font = .medium18
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Add photo to make your profile stuning"
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icImagePlaceholder.image
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let cameraButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setBackgroundImage(Asset.icGreenCamera.image, for: .normal)
        return button
    }()
    
    private lazy var addPhotoButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.setTitle("Add photo", for: .normal)
        button.titleLabel?.font = .medium16
        button.tintColor = .white
        button.addTarget(self, action: #selector(addPhotoTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.setTitle("Skip for now", for: .normal)
        button.titleLabel?.font = .medium16
        button.tintColor = .white
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    private func setupViews() {
        view.addSubviews([navigationBar, tipLabel, imageView, cameraButton, buttonsStackView])
        buttonsStackView.addArrangedSubviews([addPhotoButton, skipButton])
    }
    
    private func setupConstraints() {
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(tipLabel.snp.bottom).offset(23)
            make.centerX.equalToSuperview()
            make.size.equalTo(128)
        }
        cameraButton.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom).offset(-8)
            make.trailing.equalTo(imageView.snp.trailing)
            make.size.equalTo(32)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-48)
        }
        addPhotoButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        skipButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
    }
    
    func set(image: UIImage) {
        imageView.image = image
    }
    
    func changeAddPhotoTitle() {
        addPhotoButton.setTitle("Change photo", for: .normal)
        skipButton.setTitle("Start", for: .normal)
    }
    
    @objc func addPhotoTapped() {
        presenter?.addPhotoTapped()
    }
    
    @objc func skipTapped() {
        presenter?.skipForNowTapped()
    }
}
