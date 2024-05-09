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
    private weak var coordinator: INewPostCoordinator?
    private var announcement: Announcement
    var categories: [CategoryFilter] = [
        CategoryFilter(category: .softwareDevelopment, isChosen: false),
        CategoryFilter(category: .math, isChosen: false),
        CategoryFilter(category: .dataAnalysis, isChosen: false),
        CategoryFilter(category: .languages, isChosen: false),
        CategoryFilter(category: .literature, isChosen: false),
        CategoryFilter(category: .biology, isChosen: false),
        CategoryFilter(category: .chemistry, isChosen: false),
        CategoryFilter(category: .others, isChosen: false)
    ]
    
    init(announcement: Announcement, view: ICategorySelectionView, coordinator: INewPostCoordinator) {
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
        announcement.category = chosen.category.title
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
