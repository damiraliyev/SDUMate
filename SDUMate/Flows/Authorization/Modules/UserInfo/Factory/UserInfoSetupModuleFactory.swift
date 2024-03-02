//
//  UserInfoSetupModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import Foundation

final class UserInfoSetupModuleFactory {
    
    func makeAboutSetupView(coordinator: IUserInfoSetupCoordinator) -> IAboutSetupView {
        let view: IAboutSetupView = AboutSetupViewController()
        let presenter: IAboutSetupPresenter = AboutSetupPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
