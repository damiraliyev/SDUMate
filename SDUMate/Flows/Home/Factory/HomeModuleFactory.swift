//
//  HomeModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 17.03.2024.
//

import Foundation

final class HomeModuleFactory {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeHomeView(coordinator: IHomeCoordinator) -> IHomeView & Presentable {
        let view: IHomeView = HomeViewController()
        let presenter: IHomePresenter = HomePresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makeFilterView(coordinator: IHomeCoordinator) -> IFilterView {
        let view: IFilterView = FilterViewController()
        let presenter: IFilterPresenter = FilterPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makeAnnouncementDetailsView(announcement: Announcement, coordinator: IHomeCoordinator) -> IAnnouncementDetailsView {
        let view: IAnnouncementDetailsView = AnnouncementDetailsViewController(announcement: announcement)
        let presenter: IAnnouncementDetailsPresenter = AnnouncementDetailsPresenter(view: view, coordinator: coordinator)
        presenter.onBackTapped = { [weak coordinator] in
            coordinator?.onBackTapped(completion: nil)
        }
        view.presenter = presenter
        return view
    }
}
