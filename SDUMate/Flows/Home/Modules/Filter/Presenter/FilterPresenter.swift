//
//  FilterPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 22.03.2024.
//

import Foundation

protocol IFilterPresenter: AnyObject {
    func closeTapped()
}

final class FilterPresenter: IFilterPresenter {
    
    weak var view: IFilterView?
    private weak var coordinator: IHomeCoordinator?
    
    init(view: IFilterView, coordinator: IHomeCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func closeTapped() {
        coordinator?.dismissPresenterModule(completion: nil)
    }
}
