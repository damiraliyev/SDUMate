//
//  EditFieldPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import Foundation

protocol IEditFieldPresenter: AnyObject {
    func backTapped()
    func saveTapped(for item: EditProfileTableItem, value: String?)
}

final class EditFieldPresenter: IEditFieldPresenter {
    
    weak var view: IEditFieldView?
    private weak var coordinator: IEditProfileCoordinator?
    private var editableUserInfo: EditableUserInfo
    
    init(view: IEditFieldView, coordinator: IEditProfileCoordinator, editableUserInfo: EditableUserInfo) {
        self.view = view
        self.coordinator = coordinator
        self.editableUserInfo = editableUserInfo
    }
    
    func backTapped() {
        coordinator?.popModule(completion: nil)
    }
    
    func saveTapped(for item: EditProfileTableItem, value: String?) {
        guard let value = value else { return }
        var dict: [String: String] = [:]
        switch item {
        case .name:
            editableUserInfo.userInfo["name"] = value
            dict["name"] = value
        case .surname:
            editableUserInfo.userInfo["surname"] = value
            dict["surname"] = value
        case .nickname:
            editableUserInfo.userInfo["nickname"] = value
            dict["nickname"] = value
        case .telegram:
            editableUserInfo.userInfo["telegram_tag"] = value
        case .email:
            break
        case .faculty:
            break
        case .profession:
            break
        case .yearOfEntering:
            break
        }
        coordinator?.popModule(completion: nil)
    }
}
