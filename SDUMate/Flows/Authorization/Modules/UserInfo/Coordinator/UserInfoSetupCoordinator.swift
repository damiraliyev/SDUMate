//
//  UserInfoSetupCoordinaotr.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import UIKit

protocol IUserInfoSetupCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
}

final class UserInfoSetupCoordinator: BaseCoordinator, IUserInfoSetupCoordinator {
    var onFlowDidFinish: Completion?
    
    private let moduleFactory =  UserInfoSetupModuleFactory()
    
    override func start() {
        let aboutView = moduleFactory.makeAboutSetupView(coordinator: self)
        router.push(aboutView)
    }
}
