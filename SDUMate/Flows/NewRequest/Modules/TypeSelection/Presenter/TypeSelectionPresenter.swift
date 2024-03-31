//
//  TypeSelectionPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 31.03.2024.
//

import Foundation

protocol ITypeSelectionPresenter: AnyObject {
    func backTapped()
}

final class TypeSelectionPresenter: ITypeSelectionPresenter {
    
    weak var view: ITypeSelectionView?
    private weak var coordinator: INewRequestCoordinator?
    
    init(view: ITypeSelectionView, coordinator: INewRequestCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
}
