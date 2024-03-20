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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .cyan
    }
    
    private func setupConstraints() {
        
    }
}

extension HomeViewController: IHomeView {
    
}
