//
//  CategorySelectionPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 31.03.2024.
//

import Foundation

protocol ICategorySelectionPresenter: AnyObject {
    var categories: [CategoryFilter] { get }
    func backTapped()
    func continueTapped()
    func didSelectItem(at indexPath: IndexPath)
    func cancelTapped()
}

final class CategorySelectionPresenter: ICategorySelectionPresenter {
    weak var view: ICategorySelectionView?
    private weak var coordinator: INewRequestCoordinator?
    private var announcement: Announcement
    var categories: [CategoryFilter] = [
        CategoryFilter(name: "Software Engineering", isChosen: false),
        CategoryFilter(name: "UI/UX Design", isChosen: false),
        CategoryFilter(name: "Calculus", isChosen: false),
        CategoryFilter(name: "Linear Algebra", isChosen: false)
    ]
    
    init(announcement: Announcement, view: ICategorySelectionView, coordinator: INewRequestCoordinator) {
        self.announcement = announcement
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func continueTapped() {
        guard let chosen = getChosen() else {
            view?.shakeViews()
            return
        }
        announcement.category = chosen.name
        coordinator?.showDescriptionSetupView(announcement: announcement)
    }
    
    private func getChosen() -> CategoryFilter? {
        let chosen = categories.filter({ $0.isChosen })
        if chosen.isEmpty {
            return nil
        }
        return chosen.first
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        categories[indexPath.row].isChosen = !categories[indexPath.row].isChosen
        for i in 0..<categories.count {
            if i != indexPath.row {
                categories[i].isChosen = false
            }
        }
        view?.reload()
    }
    
    func cancelTapped() {
        let alertInput = AlertInput(title: "Confirm", message: "Are you sure you want to do this?", cancelTitle: "No", actionTitle: "Yes") {
            self.coordinator?.popToRoot()
        }
        coordinator?.presentAlert(input: alertInput)
    }
}
