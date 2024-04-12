//
//  ProvideFeedbackPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 12.04.2024.
//

import Foundation

protocol IProvideFeedbackPresenter: AnyObject {
    func doneTapped()
}

final class ProvideFeedbackPresenter: IProvideFeedbackPresenter {
    
    weak var view: IProvideFeedbackView?
    private weak var coordinator: ISessionsCoordinator?
    
    init(view: IProvideFeedbackView, coordinator: ISessionsCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func doneTapped() {
        
    }
}
