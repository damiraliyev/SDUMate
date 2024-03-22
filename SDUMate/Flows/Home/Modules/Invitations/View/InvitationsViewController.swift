//
//  InvitationsViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 22.03.2024.
//

import UIKit

protocol IInvitationsView: Presentable {
    var presenter: IInvitationsPresenter? { get set }
}

final class InvitationsViewController: BaseViewController, IInvitationsView {
    
    var presenter: IInvitationsPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "") { [weak presenter] in
        presenter?.backTapped()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([navigationBar])
    }
    
    private func setupConstraints() {
        
    }
}
