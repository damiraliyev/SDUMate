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
    
    func makeStudySetupViews(coordinator: IUserInfoSetupCoordinator) -> IStudySetupView {
        let view: IStudySetupView = StudySetupViewController()
        let presenter: IStudySetupPresenter = StudySetupPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makePhotoSetupView(coordinator: IUserInfoSetupCoordinator) -> IPhotoSetupView {
        let view: IPhotoSetupView = PhotoSetupViewController()
        let presenter: IPhotoSetupPresenter = PhotoSetupPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
