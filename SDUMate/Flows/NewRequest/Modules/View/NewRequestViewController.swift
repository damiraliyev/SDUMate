//
//  NewRequestViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

protocol INewRequestView: Presentable {
    var presenter: INewRequestPresenter? { get set }
}

final class NewRequestViewController: BaseViewController, INewRequestView {
    
    var presenter: INewRequestPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
    }
    
    private func setupConstraints() {
        
    }
}
