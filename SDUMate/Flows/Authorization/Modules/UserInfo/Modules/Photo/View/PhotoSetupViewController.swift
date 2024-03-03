//
//  PhotoSetupViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import UIKit

protocol IPhotoSetupView: Presentable {
    var presenter: IPhotoSetupPresenter? { get set }
}

final class PhotoSetupViewController: BaseViewController, IPhotoSetupView {
    
    var presenter: IPhotoSetupPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
}
