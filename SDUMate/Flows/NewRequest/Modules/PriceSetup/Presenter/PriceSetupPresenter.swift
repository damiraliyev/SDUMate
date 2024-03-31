//
//  PriceSetupPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 01.04.2024.
//

import Foundation

protocol IPriceSetupPresenter: AnyObject {
    
}

final class PriceSetupPresenter: IPriceSetupPresenter {
    
    weak var view: IPriceSetupView?
    private weak var coordinator: INewRequestCoordinator?
    
    init(view: IPriceSetupView, coordinator: INewRequestCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
