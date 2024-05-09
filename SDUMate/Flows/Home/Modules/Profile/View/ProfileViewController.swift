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
    func hideLoading()
}

final class ProfileViewController: BaseViewController, IProfileView {
    
    var presenter: IProfilePresenter?
    private let fromFlow: ProfileFromFlowType
    
    private let sections = ProfileSectionType.allCases
    
    private lazy var navigationBar = SMNavigationBar(title: "") { [weak presenter] in 
        presenter?.backTapped()
    }
    
    private let profileHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: UIView.screenWidth - 32, height: 340))
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .lavender
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .moduleDescription
        tableView.register(ProfileCell.self)
        profileHeaderView.delegate = presenter as? ProfileHeaderViewDelegate
        tableView.tableHeaderView = profileHeaderView
        let footerView = ProfileFooterView(frame: CGRect(x: 0, y: 0, width: UIView.screenWidth - 32, height: 54))
        tableView.tableFooterView = footerView
        footerView.delegate = self
        tableView.backgroundColor = ._110F2F
        tableView.rowHeight = 50
        tableView.sectionHeaderHeight = 20
        tableView.contentInset.bottom = 20
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    init(fromFlow: ProfileFromFlowType) {
        self.fromFlow = fromFlow
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupNavBar()
        setupViews()
        setupConstraints()
    }
    
    private func setupNavBar() {
        switch fromFlow {
        case .fromHome:
            navigationBar.safeShow()
        case .fromTab:
            navigationBar.safeHide()
        }
    }

    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([tableView, navigationBar])
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func set(image: UIImage) {
            
    }
    
    func configure(with user: DBUser) {
        profileHeaderView.configure(with: user)
    }
    
    func hideLoading() {
        refreshControl.endRefreshing()
    }
    
    @objc func refreshData() {
        presenter?.viewDidLoad()
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            presenter?.reviewsTapped()
        default:
            break
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let profileSection = sections[section]
        return profileSection.numOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileCell = tableView.dequeueReusableCell(for: indexPath)
        let type = sections[indexPath.section].items[indexPath.row]
        cell.configure(with: type)
        return cell
    }
}

extension ProfileViewController: ProfileFooterDelegate {
    func logOutTapped() {
        let actionSheet = UIAlertController(title: "Sign out", message: "Are you sure?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { [weak self] _ in
            self?.presenter?.logOutTapped()
        }))
        present(actionSheet, animated: true)
    }
}
