//
//  ProfileCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 24.03.2024.
//

import Foundation

protocol IProfileCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
}

final class ProfileCoordinator: BaseCoordinator, IProfileCoordinator {
    var onFlowDidFinish: Completion?
    
    private let moduleFactory: ProfileModuleFactory
    
    init(router: Router, container: DependencyContainer) {
        self.moduleFactory = ProfileModuleFactory(container: container)
        super.init(router: router)
    }
    
    override func start() {
        let profileView = moduleFactory.makeProfileView(coordinator: self)
        router.push(profileView)
    }
}


