//
//  TopContributorInfoViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.05.2024.
//

import UIKit

final class TopContributorInfoViewController: BaseViewController {
    
    private let user: DBUser
    private let type: TopContributorType
    private let place: Int
    
    private lazy var infoView = TopContributorInfoView()
    
    init(user: DBUser, type: TopContributorType, place: Int) {
        self.user = user
        self.type = type
        self.place = place
        super.init()
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
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.addSubview(infoView)
        infoView.configure(with: user, type: type, place: place)
        infoView.onCloseTapped = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    private func setupConstraints() {
        infoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
}
