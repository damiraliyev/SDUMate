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
    private var announcement: Announcement
    
    init(announcement: Announcement, view: ICategorySelectionView, coordinator: INewRequestCoordinator) {
        self.announcement = announcement
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
