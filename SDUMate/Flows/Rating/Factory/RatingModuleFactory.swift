//
//  RatingModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

final class RatingModuleFactory {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeRatingView(coordinator: IRatingCoordinator) -> IRatingView {
        let view: IRatingView = RatingViewController()
        let presenter: IRatingPresenter = RatingPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
