//
//  EditProfileCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import Foundation

protocol IEditProfileCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    func popModule(completion: Completion?)
    func showEditFieldView(for item: EditProfileTableItem)
}

final class EditProfileCoordinator: BaseCoordinator, IEditProfileCoordinator {
    var onFlowDidFinish: Completion?
    private let moduleFactory: EditProfileModuleFactory
    
    init(router: Router, container: DependencyContainer) {
        self.moduleFactory = EditProfileModuleFactory(container: container)
        super.init(router: router)
    }
    
    override func start() {
        let editProfileView = moduleFactory.makeEditProfileView(coordinator: self)
        router.push(editProfileView)
    }
    
    func dismissModule(completion: (() -> Void)?) {
        router.dismissModule { [weak self] in
            completion?()
            self?.onFlowDidFinish?()
        }
    }
    
    func popModule(completion: Completion?) {
        router.popModule()
        completion?()
    }
    
    func showEditFieldView(for item: EditProfileTableItem) {
        let editFieldView = moduleFactory.makeEditFieldView(coordinator: self, item: item)
        router.push(editFieldView)
    }
}
