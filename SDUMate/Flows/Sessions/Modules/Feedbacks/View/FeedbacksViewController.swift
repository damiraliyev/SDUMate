//
//  FeedbacksViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.04.2024.
//

import UIKit

protocol IFeedbacksView: Presentable {
    var presenter: IFeedbacksPresenter? { get set }
    
    func reload()
}

final class FeedbacksViewController: BaseViewController, IFeedbacksView {
    
    var presenter: IFeedbacksPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "Feedbacks") { [weak presenter] in
        presenter?.backTapped()
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = ._110F2F
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FeedbackCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([navigationBar, tableView])
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    func reload() {
        tableView.reloadData()
    }
}

extension FeedbacksViewController: UITableViewDelegate {
    
}

extension FeedbacksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedbackCell = tableView.dequeueReusableCell(for: indexPath)
        if let presenter = presenter {
            cell.configure(with: presenter.feedback(for: indexPath))
        }
        return cell
    }
}
