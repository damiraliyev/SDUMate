//
//  NewRequestPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol INewPostPresenter: AnyObject {
    func startTapped()
}

final class NewRequestPresenter: INewPostPresenter {
    
    weak var view: INewPostView?
    private weak var coordinator: INewPostCoordinator?
    
    init(view: INewPostView, coordinator: INewPostCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func startTapped() {
        coordinator?.startCreationFlow()
    }
}
