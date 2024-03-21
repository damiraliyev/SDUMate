//
//  SessionsViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

protocol ISessionsView: Presentable {
    var presenter: ISessionsPresenter? { get set }
}

final class SessionsViewController: BaseViewController, ISessionsView {
    
    var presenter: ISessionsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .accentOrange
    }
    
    private func setupConstraints() {
        
    }
}
