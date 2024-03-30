//
//  EditProfilePresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import Foundation

protocol IEditProfilePresenter: AnyObject {
    
}

final class EditProfilePresenter: IEditProfilePresenter {
    
    weak var view: IEditProfileView?
    private weak var coordinator: IEditProfileCoordinator?
    
    init(view: IEditProfileView, coordinator: IEditProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
