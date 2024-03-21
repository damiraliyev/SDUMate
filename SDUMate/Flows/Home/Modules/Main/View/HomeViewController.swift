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
    
    private let headerView = HomeHeaderView()
    
    private let searchFieldView = SearchFieldView()
    
    private let appliedFiltersView = AppliedFiltersView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .background
        view.addSubviews([headerView, searchFieldView, appliedFiltersView])
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(64)
        }
        searchFieldView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        appliedFiltersView.snp.makeConstraints { make in
            make.top.equalTo(searchFieldView.snp.bottom).offset(11)
            make.leading.equalTo(searchFieldView)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}

extension HomeViewController: IHomeView {
    
}
