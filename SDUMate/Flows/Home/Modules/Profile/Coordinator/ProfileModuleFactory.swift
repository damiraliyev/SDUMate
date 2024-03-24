//
//  ProfileModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 24.03.2024.
//

import Foundation

final class ProfileModuleFactory {
    
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeProfileView(coordinator: IProfileCoordinator) -> IProfileView {
        let view: IProfileView = ProfileViewController()
        let presenter: IProfilePresenter = ProfilePresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
