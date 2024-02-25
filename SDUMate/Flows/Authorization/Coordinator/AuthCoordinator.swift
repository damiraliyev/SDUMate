//
//  AuthCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Foundation

protocol IAuthCoordinator: AnyObject {
    var onFlowDidFinish: Completion? { get set }
    
    func showSignInView()
}

final class AuthCoordinator: BaseCoordinator, IAuthCoordinator {
    private let container: DependencyContainer
    private let moduleFactory: AuthModuleFactory
    private var entryView: IEntryView?
    var onFlowDidFinish: Completion?
    
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        moduleFactory = AuthModuleFactory(container: container)
        super.init(router: router)
    }
    
    override func start() {
        entryView = moduleFactory.makeEntryView(coordinator: self)
        router.push(entryView)
    }
    
    func showSignInView() {
        
    }
}
