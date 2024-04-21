//
//  CategorySelectionViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 31.03.2024.
//

import UIKit

protocol ICategorySelectionView: Presentable {
    var presenter: ICategorySelectionPresenter? { get set }
    
    func reload()
    func shakeViews()
}

final class CategorySelectionViewController: BaseViewController, ICategorySelectionView {
    
    var presenter: ICategorySelectionPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "Advertise") { [weak presenter] in
        presenter?.backTapped()
    } rightBtnTapCallback: { [weak presenter] in
        presenter?.cancelTapped()
    }
    
    private let progressView = ProgressView(iterationsCount: 5)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold20
        label.text = "Category"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.register(CategoryFilterCell.self)
        tableView.backgroundColor = ._110F2F
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
        return tableView
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
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .regular14
        label.textColor = ._FF453A
        label.text = "Select a category"
        label.safeHide()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        navigationBar.rightButtonTitle = "Cancel"
        view.addSubviews([navigationBar, progressView, titleLabel, tableView, errorLabel, continueButton])
        progressView.color(first: 2)
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
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(continueButton.snp.top).offset(-24)
        }
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-32)
            make.height.equalTo(48)
        }
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    func shakeViews() {
        errorLabel.safeShow()
        errorLabel.snp.remakeConstraints { make in
            make.top.equalTo(tableView).offset(tableView.contentSize.height + 5)
            make.leading.equalToSuperview().offset(24)
        }
        tableView.shake()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.errorLabel.safeHide()
        }
    }
    
    @objc func continueTapped() {
        presenter?.continueTapped()
    }
}

extension CategorySelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
}

extension CategorySelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        let cell: CategoryFilterCell = tableView.dequeueReusableCell(for: indexPath)
        cell.contentView.backgroundColor = ._110F2F
        cell.configure(with: presenter.categories[indexPath.row])
        return cell
    }
}
