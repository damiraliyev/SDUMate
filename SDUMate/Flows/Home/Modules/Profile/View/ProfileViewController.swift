//
//  ProfileViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 24.03.2024.
//

import UIKit
import Kingfisher

protocol IProfileView: Presentable {
    var presenter: IProfilePresenter? { get set }
    
    func set(image: UIImage)
    func configure(with user: DBUser)
}

final class ProfileViewController: BaseViewController, IProfileView {
    
    var presenter: IProfilePresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "Profile") { [weak presenter] in 
        presenter?.backTapped()
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icImagePlaceholder.image
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setBackgroundImage(Asset.icGreenCamera.image, for: .normal)
        button.addTarget(self, action: #selector(cameraTapped), for: .touchUpInside)
        return button
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 9
        stackView.alignment = .center
        return stackView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .beProWhite
        label.font = .medium24
        label.text = "Damir Aliyev"
        return label
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._cdcdcd
        label.font = .regular16
        label.text = "mntn7"
        return label
    }()
    
    private let studyInfoDetailsView: StudyInfoDetailsView = {
        let view = StudyInfoDetailsView()
        view.showDateOfEntering()
        return view
    }()
    
    private let contactDetailsView: UserContactDetailsView = {
        let view = UserContactDetailsView()
        view.unhideInfo()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([navigationBar, profileImageView, cameraButton, labelsStackView, studyInfoDetailsView, contactDetailsView])
        labelsStackView.addArrangedSubviews([fullNameLabel, nicknameLabel])
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
            make.size.equalTo(105)
        }
        cameraButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom).offset(-8)
            make.trailing.equalTo(profileImageView.snp.trailing)
            make.size.equalTo(28)
        }
        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(9)
            make.centerX.equalToSuperview()
        }
        studyInfoDetailsView.snp.makeConstraints { make in
            make.top.equalTo(labelsStackView.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        contactDetailsView.snp.makeConstraints { make in
            make.top.equalTo(studyInfoDetailsView.snp.bottom).offset(17)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    func set(image: UIImage) {
        profileImageView.image = image
    }
    
    func configure(with user: DBUser) {
        profileImageView.kf.setImage(with: URL(string: user.profileImageUrl ?? ""))
        fullNameLabel.text = "\(user.name ?? "") \(user.surname ?? "")"
        nicknameLabel.text = user.nickname ?? ""
        studyInfoDetailsView.configure(with: user)
        contactDetailsView.configure(with: user)
    }
    
    @objc func cameraTapped() {
        presenter?.cameraTapped()
    }
}
