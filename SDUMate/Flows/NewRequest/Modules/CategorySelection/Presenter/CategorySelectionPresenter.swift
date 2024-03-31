//
//  CategorySelectionPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 31.03.2024.
//

import Foundation

protocol ICategorySelectionPresenter: AnyObject {
    func backTapped()
    func continueTapped()
}

final class CategorySelectionPresenter: ICategorySelectionPresenter {
    weak var view: ICategorySelectionView?
    private weak var coordinator: INewRequestCoordinator?
    
    init(view: ICategorySelectionView, coordinator: INewRequestCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func continueTapped() {
        coordinator?.showDescriptionSetupView()
    }
}
