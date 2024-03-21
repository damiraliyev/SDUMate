//
//  SessionsCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

import Foundation

protocol ISessionsCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    
    func onBackTapped(completion: Completion?)
}

final class SessionsCoordinator: BaseCoordinator, ISessionsCoordinator {
    private let container: DependencyContainer
    private let moduleFactory: SessionsModuleFactory
    var onFlowDidFinish: Completion?
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        moduleFactory = SessionsModuleFactory(container: container)
        super.init(router: router)
    }
    
    override func start() {
        let sessionView = moduleFactory.makeSessionsView(coordinator: self)
        router.setRootModule(sessionView)
    }
    
    func onBackTapped(completion: Completion?) {
        
    }
}

