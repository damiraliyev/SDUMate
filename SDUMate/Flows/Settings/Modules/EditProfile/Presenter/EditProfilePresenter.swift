//
//  EditProfilePresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import Foundation

protocol IEditProfilePresenter: AnyObject {
    func doneTapped()
    func cancelTapped()
    func didSelectRowAt(_ indexPath: IndexPath)
}

final class EditProfilePresenter: IEditProfilePresenter {
    
    weak var view: IEditProfileView?
    private weak var coordinator: IEditProfileCoordinator?
    private let sections = EditProfileTableSectionType.allCases
    
    init(view: IEditProfileView, coordinator: IEditProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func doneTapped() {
        coordinator?.popModule(completion: { [weak self] in
            self?.coordinator?.onFlowDidFinish?()
        })
    }
    
    func cancelTapped() {
        coordinator?.popModule(completion: { [weak self] in
            self?.coordinator?.onFlowDidFinish?()
        })
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        coordinator?.showEditFieldView(for: item)
    }
}
