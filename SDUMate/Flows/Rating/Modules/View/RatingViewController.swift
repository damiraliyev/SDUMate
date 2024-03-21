//
//  RatingViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

protocol IRatingView: Presentable {
    var presenter: IRatingPresenter? { get set }
}

final class RatingViewController: BaseViewController, IRatingView {
    
    var presenter: IRatingPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .accentGrey
    }
    
    private func setupConstraints() {
        
    }
}
