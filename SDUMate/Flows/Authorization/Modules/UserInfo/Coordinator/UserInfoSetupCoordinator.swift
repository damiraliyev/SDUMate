//
//  UserInfoSetupCoordinaotr.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import UIKit

protocol IUserInfoSetupCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    
    func onBackTapped(completion: Completion?)
    func showStudySetupView()
    func showPhotoSetupView()
}

final class UserInfoSetupCoordinator: BaseCoordinator, IUserInfoSetupCoordinator {
    var onFlowDidFinish: Completion?
    
    private let moduleFactory =  UserInfoSetupModuleFactory()
    
    override func start() {
        let aboutView = moduleFactory.makeAboutSetupView(coordinator: self)
        router.push(aboutView)
    }
    
    func onBackTapped(completion: Completion?) {
        router.popModule()
        completion?()
    }
    
    func showStudySetupView() {
        let studySetupView = moduleFactory.makeStudySetupViews(coordinator: self)
        router.push(studySetupView)
    }
    
    func showPhotoSetupView() {
        let photoSetupView = moduleFactory.makePhotoSetupView(coordinator: self)
        router.push(photoSetupView)
    }
}
