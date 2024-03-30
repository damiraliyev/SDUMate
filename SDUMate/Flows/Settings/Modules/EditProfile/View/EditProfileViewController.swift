//
//  EditProfileViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import UIKit

protocol IEditProfileView: Presentable {
    var presenter: IEditProfilePresenter? { get set }
}

final class EditProfileViewController: BaseViewController, IEditProfileView {
    
    var presenter: IEditProfilePresenter?
    
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

