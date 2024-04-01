//
//  RequestSummaryPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 01.04.2024.
//

import Foundation

protocol IRequestSummaryPresenter: AnyObject {
    func backTapped()
    func postTapped()
}

final class RequestSummaryPresenter: IRequestSummaryPresenter {
    
    weak var view: IRequestSummaryView?
    private weak var coordinator: INewRequestCoordinator?
    
    init(view: IRequestSummaryView, coordinator: INewRequestCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func postTapped() {
        
    }
}
