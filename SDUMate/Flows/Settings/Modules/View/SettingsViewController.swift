//
//  SettingsViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

protocol ISettingsView: Presentable {
    var presenter: ISettingsPresenter? { get set }
}

final class SettingsViewController: BaseViewController, ISettingsView {
    
    var presenter: ISettingsPresenter?
    
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
