//
//  EntryViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import UIKit

protocol IEntryView: Presentable {
    var presenter: IEntryPresenter? { get set }
}

final class EntryViewController: BaseViewController, IEntryView {
    var presenter: IEntryPresenter?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bold48
        label.text = "SDUMate"
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = Asset.background.color
        view.addSubviews([titleLabel])
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-((view.frame.height - titleLabel.font.lineHeight) * 0.06))
            make.centerX.equalToSuperview()
        }
    }
}
