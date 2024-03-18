//
//  HomePresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 17.03.2024.
//

import Foundation

protocol IHomePresenter {
    
}

final class HomePresenter: IHomePresenter {
    weak var view: IHomeView?
    private let coordinator: IHomeCoordinator?
    
    init(view: IHomeView, coordinator: IHomeCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
