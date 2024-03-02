//
//  StudySetupViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import UIKit

protocol IStudySetupView: Presentable {
    var presenter: IStudySetupPresenter? { get set }
}

final class StudySetupViewController: BaseViewController, IStudySetupView {
    
    var presenter: IStudySetupPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "Study") { [weak presenter] in
        presenter?.backTapped()
    }
    
    override func loadView() {
        super.loadView()
        self.view = AuthView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubviews([navigationBar])
    }
    
    private func setupConstraints() {
        
    }
}
