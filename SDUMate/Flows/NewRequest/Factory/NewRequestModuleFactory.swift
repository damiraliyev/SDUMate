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
}
