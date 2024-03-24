//
//  ProfileViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 24.03.2024.
//

import UIKit

protocol IProfileView: Presentable {
    var presenter: IProfilePresenter? { get set }
}

final class ProfileViewController: BaseViewController, IProfileView {
    
    var presenter: IProfilePresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "Profile") { [weak presenter] in 
        presenter?.backTapped()
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 9
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
    
    private let contactDetailsView = UserContactDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([profileImageView, labelsStackView, studyInfoDetailsView, contactDetailsView])
        labelsStackView.addArrangedSubviews([fullNameLabel, nicknameLabel])
    }
    
    private func setupConstraints() {
//        profileImageView
    }
}
