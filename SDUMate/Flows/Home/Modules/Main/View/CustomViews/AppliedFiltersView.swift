//
//  AppliedFiltersView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

protocol AppliedFiltersDelegate: AnyObject {
    func filterTapped()
}

final class AppliedFiltersView: UIView {
    
    weak var delegate: AppliedFiltersDelegate?
    
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Asset.icFilter.image, for: .normal)
        button.layer.cornerRadius = 7
        button.backgroundColor = ._282645
        button.tintColor = .white
        button.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AppliedFilterCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
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
        backgroundColor = .clear
        addSubviews([filterButton, collectionView])
    }
    
    private func setupConstraints() {
        filterButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(40)
        }
        collectionView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(filterButton.snp.trailing).offset(4)
        }
    }
    
    private func flowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 4
        layout.sectionInset.left = 4
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }
    
    @objc func filterTapped() {
        delegate?.filterTapped()
    }
}

extension AppliedFiltersView: UICollectionViewDelegate {
    
}

extension AppliedFiltersView: UICollectionViewDelegateFlowLayout {
    
}

extension AppliedFiltersView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AppliedFilterCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    
    
}
