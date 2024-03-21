//
//  SettingsModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

final class SettingsModuleFactory {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeSettingsView(coordinator: ISettingsCoordinator) -> ISettingsView {
        let view: ISettingsView = SettingsViewController()
        let presenter: ISettingsPresenter = SettingsPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
