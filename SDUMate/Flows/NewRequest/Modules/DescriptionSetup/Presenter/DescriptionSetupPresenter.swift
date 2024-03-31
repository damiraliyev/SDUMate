//
//  DescriptionSetupPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 31.03.2024.
//

import Foundation

protocol IDescriptionSetupPresenter: AnyObject {
    func backTapped()
    func continueTapped()
}

final class DescriptionSetupPresenter: IDescriptionSetupPresenter {
    weak var view: IDescriptionSetupView?
    private weak var coordinator: INewRequestCoordinator?
    
    init(view: IDescriptionSetupView, coordinator: INewRequestCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func continueTapped() {
        coordinator?.showPriceSetupView()
    }
}
