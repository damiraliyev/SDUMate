//
//  CollectionCell.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 02.09.2023.
//

import UIKit

open class CollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setupViews() {}
}
