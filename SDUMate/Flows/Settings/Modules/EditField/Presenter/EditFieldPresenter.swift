//
//  EditFieldPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import Foundation

protocol IEditFieldPresenter: AnyObject {
    func backTapped()
}

final class EditFieldPresenter: IEditFieldPresenter {
    
    weak var view: IEditFieldView?
    private weak var coordinator: IEditProfileCoordinator?
    
    init(view: IEditFieldView, coordinator: IEditProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.popModule(completion: nil)
    }
}
