//
//  EntryPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Foundation

protocol IEntryPresenter: AnyObject {
    
}

final class EntryPresenter: IEntryPresenter {
    private let coordinator: IAuthCoordinator
    weak var view: IEntryView?
    
    init(coordinator: IAuthCoordinator, view: IEntryView) {
        self.coordinator = coordinator
        self.view = view
    }
}
