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
    
    private let topContributorsLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold28
        label.text = "Top contributors"
        return label
    }()
    
    private let glassButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icLoupe.image, for: .normal)
        button.backgroundColor = ._110F2F
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([topContributorsLabel, glassButton])
    }
    
    private func setupConstraints() {
        topContributorsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(22)
            make.leading.equalToSuperview().offset(16)
        }
        glassButton.snp.makeConstraints { make in
            make.centerY.equalTo(topContributorsLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(19)
        }
    }
}
