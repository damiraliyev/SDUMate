//
//  ProgressView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 31.03.2024.
//

import UIKit

final class ProgressView: UIView {
    
    private let iterationsCount: Int
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init(iterationsCount: Int) {
        self.iterationsCount = iterationsCount
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.arrangedSubviews.forEach {
            $0.layer.cornerRadius = frame.height / 2
        }
    }
    
    private func setupViews() {
        addSubview(stackView)
        for _ in 0..<iterationsCount {
            let view = createProgressView()
            stackView.addArrangedSubview(view)
            view.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
            }
        }
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createProgressView() -> UIView {
        let view = UIView()
        view.backgroundColor = ._d9d9d9
        view.layer.cornerRadius = 1.5
        return view
    }
    
    func color(first number: Int) {
        for i in 0..<number {
            stackView.arrangedSubviews[safe: i]?.backgroundColor = ._0A84FF
        }
    }
}
