//
//  RatingViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

protocol IRatingView: Presentable {
    var presenter: IRatingPresenter? { get set }
}

final class RatingViewController: BaseViewController, IRatingView {
    
    var presenter: IRatingPresenter?
    
    private let topContributorsLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold28
        label.text = "Top contributors"
        return label
    }()
    
    private let glassButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icLoupe.image, for: .normal)
        button.backgroundColor = ._110F2F
        return button
    }()
    
    private lazy var headerView = RatingHeaderView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = ._110F2F
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
//        tableView.estimatedSectionHeaderHeight = 100
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headerView.snp.remakeConstraints { make in
            make.height.equalTo(headerView.getHeight())
            make.top.equalTo(topContributorsLabel.snp.bottom).offset(8).priority(.high)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([topContributorsLabel, glassButton, headerView, tableView])
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
    
    private func setupConstraints() {
        topContributorsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(22)
            make.leading.equalToSuperview().offset(16)
        }
        glassButton.snp.makeConstraints { make in
            make.centerY.equalTo(topContributorsLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(19)
        }
        headerView.snp.makeConstraints { make in
            make.top.equalTo(topContributorsLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}

extension RatingViewController: UITableViewDelegate {
    
}

extension RatingViewController: UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 220
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 292
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
