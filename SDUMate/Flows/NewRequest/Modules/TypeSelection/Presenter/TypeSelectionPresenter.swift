//
//  TypeSelectionPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 31.03.2024.
//

import Foundation

protocol ITypeSelectionPresenter: AnyObject {
    func backTapped()
    func continueTapped(title: String, selectedTypeIndex: Int)
}

final class TypeSelectionPresenter: ITypeSelectionPresenter {
    
    weak var view: ITypeSelectionView?
    private weak var coordinator: INewRequestCoordinator?
    private let announcementTypes = AnnounceType.allCases
    
    init(view: ITypeSelectionView, coordinator: INewRequestCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func continueTapped(title: String, selectedTypeIndex: Int) {
        guard !title.isEmpty else { return }
        var announcement = Announcement()
        announcement.title = title
        announcement.type = announcementTypes[selectedTypeIndex]
        coordinator?.showCategorySelectionView(announcement: announcement)
    }
}
