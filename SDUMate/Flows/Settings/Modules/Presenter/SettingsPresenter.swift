//
//  SettingsPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol ISettingsPresenter: AnyObject {
    
}

final class SettingsPresenter: ISettingsPresenter {
    
    weak var view: ISettingsView?
    private weak var coordinator: ISettingsCoordinator?
    
    init(view: ISettingsView, coordinator: ISettingsCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
