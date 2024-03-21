//
//  RatingPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol IRatingPresenter: AnyObject {
    
}

final class RatingPresenter: IRatingPresenter {
    weak var view: IRatingView?
    private weak var coordinator: IRatingCoordinator?
    
    init(view: IRatingView, coordinator: IRatingCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
