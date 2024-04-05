//
//  HomeViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 17.03.2024.
//

import UIKit

protocol IHomeView: Presentable {
    var presenter: IHomePresenter? { get set }
    
    func configureAppliedFilters(with filter: AppliedFilter)
    func setupHeader(fullName: String, nickname: String)
    func reload()
}

final class HomeViewController: BaseViewController {
    var presenter: IHomePresenter?
    
    private lazy var headerView: HomeHeaderView = {
        let view = HomeHeaderView()
        view.delegate = presenter as? HomeHeaderViewDelegate
        return view
    }()
    
    private let searchFieldView = SearchFieldView()
    
    private lazy var appliedFiltersView: AppliedFiltersView = {
        let view = AppliedFiltersView()
        view.delegate = self
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AnnouncementCell.self)
        collectionView.contentInset.top = 0
        collectionView.contentInset.bottom = 24
        collectionView.alwaysBounceVertical = true
        collectionView.isSkeletonable = true
        collectionView.register(AnnouncementCell.self)
        collectionView.refreshControl = refreshControl
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([headerView, searchFieldView, appliedFiltersView, collectionView])
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(64)
        }
        searchFieldView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
        appliedFiltersView.snp.makeConstraints { make in
            make.top.equalTo(searchFieldView.snp.bottom).offset(11)
            make.leading.equalTo(searchFieldView)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(appliedFiltersView.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func refreshData() {
        presenter?.viewDidLoad()
    }
}

extension HomeViewController: IHomeView {
    func configureAppliedFilters(with filter: AppliedFilter) {
        appliedFiltersView.configure(filter)
    }
    
    func setupHeader(fullName: String, nickname: String) {
        headerView.configure(fullName: fullName, nickname: nickname)
    }
    
    func reload() {
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width - 32
        let height: CGFloat = 172
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.announcementsDataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnnouncementCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: presenter?.announcementsDataSource[indexPath.item] ?? Announcement())
        return cell
    }
}

extension HomeViewController: AppliedFiltersDelegate {
    func filterTapped() {
        presenter?.filterTapped()
    }
    
    func typeRemoved() {
        presenter?.typeRemoved()
    }
    
    func categoryRemoved(at indexPath: IndexPath) {
        presenter?.categoryRemoved(at: indexPath)
    }
}
