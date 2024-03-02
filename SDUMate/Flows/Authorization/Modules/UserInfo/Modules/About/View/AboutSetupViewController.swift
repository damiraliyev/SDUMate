//
//  AboutSetupViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import Foundation

protocol IAboutSetupView: Presentable {
    var presenter: IAboutSetupPresenter? { get set }
}

final class AboutSetupViewController: BaseViewController, IAboutSetupView {
    
    var presenter: IAboutSetupPresenter?
    
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
