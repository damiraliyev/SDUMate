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
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([startButton])
    }
    
    private func setupConstraints() {
        startButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(54)
        }
    }
    
    @objc func startTapped() {
        presenter?.startTapped()
    }
}
