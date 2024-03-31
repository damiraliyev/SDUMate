//
//  TypeSelectionViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 31.03.2024.
//

import UIKit

protocol ITypeSelectionView: Presentable {
    var presenter: ITypeSelectionPresenter? { get set }
}

final class TypeSelectionViewController: BaseViewController, ITypeSelectionView {
    
    var presenter: ITypeSelectionPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "Advertise") { [weak presenter] in
        presenter?.backTapped()
    } rightBtnTapCallback: {
        print("CANCEL TAPPED")
    }
    
    private let progressView = ProgressView(iterationsCount: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        navigationBar.isRightButtonHidden = false
        navigationBar.rightButtonTitle = "Cancel"
        view.addSubviews([navigationBar, progressView])
        progressView.color(first: 1)
    }
    
    private func setupConstraints() {
        progressView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(23)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(3)
        }
    }
}
