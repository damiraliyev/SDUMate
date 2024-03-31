//
//  EditProfileViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import UIKit

protocol IEditProfileView: Presentable {
    var presenter: IEditProfilePresenter? { get set }
    
    func set(image: UIImage?)
    func reload()
}

final class EditProfileViewController: BaseViewController, IEditProfileView {
    
    var presenter: IEditProfilePresenter?
    private let sections = EditProfileTableSectionType.allCases
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.lavender, for: .normal)
        button.titleLabel?.font = .medium14
        button.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.lavender, for: .normal)
        button.titleLabel?.font = .medium14
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerView = EditProfileHeaderView(frame: CGRect(x: 0, y: 0, width: UIView.screenWidth, height: UIView.screenHeight / 5.3))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = true
        tableView.backgroundColor = ._110F2F
        tableView.rowHeight = 42
        headerView.delegate = presenter as? EditProfileHeaderDelegate
        tableView.tableHeaderView = headerView
        tableView.sectionHeaderHeight = 20
        tableView.contentInset.bottom = 20
        tableView.register(EditProfileCell.self)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .moduleDescription
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([doneButton, cancelButton, tableView])
    }
    
    private func setupConstraints() {
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(1)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(21)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(1)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(21)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(doneButton.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func set(image: UIImage?) {
        headerView.set(image: image)
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    @objc func doneTapped() {
        presenter?.doneTapped()
    }
    
    @objc func cancelTapped() {
        presenter?.cancelTapped()
    }
}

extension EditProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath)
    }
}

extension EditProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EditProfileCell = tableView.dequeueReusableCell(for: indexPath)
        let section = sections[indexPath.section]
        guard let viewModel = presenter?.getViewModel(forCellAt: indexPath) else { return cell}
        cell.configure(with: viewModel)
        return cell
    }
}
