//
//  SettingsCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol ISettingsCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    
    func onBackTapped(completion: Completion?)
}

final class SettingsCoordinator: BaseCoordinator, ISettingsCoordinator {
    private let container: DependencyContainer
    private let moduleFactory: SettingsModuleFactory
    var onFlowDidFinish: Completion?
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        moduleFactory = SettingsModuleFactory(container: container)
        super.init(router: router)
    }
    
    override func start() {
        let settingsView = moduleFactory.makeSettingsView(coordinator: self)
        router.setRootModule(settingsView)
    }
    
    func onBackTapped(completion: Completion?) {
        
    }
}
