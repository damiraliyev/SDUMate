//
//  NewRequestModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

final class NewRequestModuleFactory {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeNewRequestView(coordinator: INewRequestCoordinator) -> INewRequestView {
        let view: INewRequestView = NewRequestViewController()
        let presenter: INewRequestPresenter = NewRequestPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makeTypeSelectionView(coordinator: INewRequestCoordinator) -> ITypeSelectionView {
        let view: ITypeSelectionView = TypeSelectionViewController()
        let presenter: ITypeSelectionPresenter = TypeSelectionPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makeCategorySelectionView(announcement: Announcement, coordinator: INewRequestCoordinator) -> ICategorySelectionView {
        let view: ICategorySelectionView = CategorySelectionViewController()
        let presenter: ICategorySelectionPresenter = CategorySelectionPresenter(announcement: announcement, view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makeDescriptionSetupView(announcement: Announcement, coordinator: INewRequestCoordinator) -> IDescriptionSetupView {
        let view: IDescriptionSetupView = DescriptionSetupViewController()
        let presenter: IDescriptionSetupPresenter = DescriptionSetupPresenter(announcement: announcement, view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makePriceSetupView(announcement: Announcement, coordinator: INewRequestCoordinator) -> IPriceSetupView {
        let view: IPriceSetupView = PriceSetupViewController()
        let presenter: IPriceSetupPresenter = PriceSetupPresenter(announcement: announcement, view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makeRequestSummaryView(announcement: Announcement, coordinator: INewRequestCoordinator) -> IRequestSummaryView {
        let view: IRequestSummaryView = RequestSummaryViewController()
        let presenter: IRequestSummaryPresenter = RequestSummaryPresenter(announcement: announcement, view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
