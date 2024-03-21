//
//  SessionsModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

final class SessionsModuleFactory {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeSessionsView(coordinator: ISessionsCoordinator) -> ISessionsView {
        let view: ISessionsView = SessionsViewController()
        let presenter: ISessionsPresenter = SessionsPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
