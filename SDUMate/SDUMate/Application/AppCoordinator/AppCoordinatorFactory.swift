//
//  AppCoordinatorFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Foundation

final class AppCordinatorFactory {
    private let container: DependencyContainer
    private let router: Router
    
    init(router: Router, container: DependencyContainer) {
        self.router = router
        self.container = container
    }
}
