//
//  EditProfileModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import Foundation

final class EditProfileModuleFactory {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeEditProfileView(coordinator: IEditProfileCoordinator) -> IEditProfileView {
        let view: IEditProfileView = EditProfileViewController()
        let presenter: IEditProfilePresenter = EditProfilePresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
