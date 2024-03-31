//
//  NewRequestPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol INewRequestPresenter: AnyObject {
    func startTapped()
}

final class NewRequestPresenter: INewRequestPresenter {
    
    weak var view: INewRequestView?
    private weak var coordinator: INewRequestCoordinator?
    
    init(view: INewRequestView, coordinator: INewRequestCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func startTapped() {
        coordinator?.startCreationFlow()
    }
}
