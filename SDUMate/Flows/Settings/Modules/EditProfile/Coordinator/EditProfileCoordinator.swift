//
//  EditProfileCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import Foundation

protocol IEditProfileCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
}

final class EditProfileCoordinator: BaseCoordinator, IEditProfileCoordinator {
    var onFlowDidFinish: Completion?
    private let moduleFacory: EditProfileModuleFactory
    
    init(router: Router, container: DependencyContainer) {
        self.moduleFacory = EditProfileModuleFactory(container: container)
        super.init(router: router)
    }
}
