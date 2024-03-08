//
//  DependencyContainerAssembly.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Swinject
import CoreLocation
import Moya

public typealias DependencyContainer = Resolver

final class DependencyContainerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthManager.self) { _ in
            AuthManager.shared
        }
    }
}
