//
//  EntryCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Foundation

protocol IEntryCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
}

final class EntryCoordinator: BaseCoordinator, IEntryCoordinator {
    var onFlowDidFinish: Completion?
    
    private let moduleFactory: EntryModuleFactory
    
    override init(router: Router) {
        moduleFactory = EntryModuleFactory()
        super.init(router: router)
    }
    
}
