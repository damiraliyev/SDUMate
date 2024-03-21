//
//  SearchFieldView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

final class SearchFieldView: UIView {
    
    private let loupeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.icLoupe.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var searchField: UITextField = {
        let field = UITextField()
        field.backgroundColor = ._282645
        field.textColor = .white
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lavender]
        field.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributes)
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return field
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = ._282645
        layer.cornerRadius = 10
        addSubviews([loupeImageView, searchField])
    }
    
    private func setupConstraints() {
        loupeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.size.equalTo(15)
        }
        searchField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(loupeImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        
    }
}
