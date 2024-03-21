//
//  HomeViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 17.03.2024.
//

import UIKit

protocol IHomeView: Presentable {
    var presenter: IHomePresenter? { get set }
}

final class HomeViewController: BaseViewController {
    var presenter: IHomePresenter?
    
    private let announcements = [
        Announcement(category: "Software Engineering", title: "Object oriented programming", description: "Object-oriented programming (OOP) is a computer programming model that organizes software design around data, or objects, rather than functions and logic. An object can be defined as a data field that has unique attributes and behavior.", announcer: "mntn7", rating: "5/5", reviewsCount: 55, price: "FREE"),
        Announcement(category: "Software Engineering", title: "Unit testing iOS", description: "Unit testing is the process where you test the smallest functional unit of code. Software testing helps ensure code quality, and it's an integral part of software development.", announcer: "bekzhan", rating: "5/5", reviewsCount: 50, price: "5000 ₸"),
        Announcement(category: "Software Engineering", title: "Swift UI", description: "SwiftUI is an innovative, exceptionally simple way to build user interfaces across all Apple platforms with the power of Swift.", announcer: "mntn7", rating: "5/5", reviewsCount: 55, price: "10 000 ₸"),
        Announcement(category: "Software Engineering", title: "Swift concurrency", description: "The concurrency model in Swift is built on top of threads, but you don't interact with them directly.", announcer: "mntn7", rating: "5/5", reviewsCount: 55, price: "FREE"),
    ]
    
    private let headerView = HomeHeaderView()
    
    private let searchFieldView = SearchFieldView()
    
    private let appliedFiltersView = AppliedFiltersView()
    
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
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .background
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
}

extension HomeViewController: IHomeView {
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width - 32
        let height: CGFloat = 156
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return announcements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnnouncementCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: announcements[indexPath.item])
        return cell
    }
}
