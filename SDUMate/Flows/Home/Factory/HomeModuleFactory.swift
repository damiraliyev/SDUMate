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
}
