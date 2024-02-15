//
//  AuthCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Foundation

protocol IAuthCoordinator: AnyObject {
    var onFlowDidFinish: Completion? { get set }
}

final class AuthCoordinator: BaseCoordinator, IAuthCoordinator {
    private let container: DependencyContainer
    private let moduleFactory: AuthModuleFactory
    var onFlowDidFinish: Completion?
    
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        moduleFactory = AuthModuleFactory(container: container)
        super.init(router: router)
    }
}
