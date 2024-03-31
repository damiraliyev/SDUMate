//
//  NewRequestPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol INewRequestPresenter: AnyObject {
    
}

final class NewRequestPresenter: INewRequestPresenter {
    
    weak var view: INewRequestView?
    private weak var coordinator: INewRequestCoordinator?
    
    init(view: INewRequestView, coordinator: INewRequestCoordinator) {
        self.view = view
        self.coordinator = coordinator
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.coordinator?.onBackTapped(completion: nil)
        }
    }
}
