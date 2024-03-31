//
//  EditFieldPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import Foundation

enum VerificationResponse {
    case correct
    case emptyValue
    case withoutChange
}

protocol IEditFieldPresenter: AnyObject {
    func backTapped()
    func saveTapped(for item: EditProfileTableItem, value: String?)
}

final class EditFieldPresenter: IEditFieldPresenter {
    
    weak var view: IEditFieldView?
    private weak var coordinator: IEditProfileCoordinator?
    private var editableUserInfo: EditableUserInfo
    private let initialValue: String?

    
    init(view: IEditFieldView, coordinator: IEditProfileCoordinator, editableUserInfo: EditableUserInfo, initialValue: String?) {
        self.view = view
        self.coordinator = coordinator
        self.editableUserInfo = editableUserInfo
        self.initialValue = initialValue
        self.view?.set(initialValue: initialValue)
    }
    
    func backTapped() {
        coordinator?.popModule(completion: nil)
    }
    
    func saveTapped(for item: EditProfileTableItem, value: String?) {
        guard let value = value else { return }
        
        let verificationResponse = makeVerification(text: value)
        
        switch verificationResponse {
        case .correct:
            update(value: value, for: item)
        case .emptyValue:
            view?.showError(withText: "You can not provide empty value")
        case .withoutChange:
            view?.showError(withText: "Value is the same")
        }
    }
    
    func makeVerification(text: String?) -> VerificationResponse {
        if text == nil || (text ?? "").isEmpty {
            return .emptyValue
        } else if text == initialValue {
            return .withoutChange
        }
        return .correct
    }
    
    private func update(value: String, for item: EditProfileTableItem) {
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
        guard let id = AuthManager.shared.getAuthUser()?.uid else {
            coordinator?.showErrorAlert(error: "Something went wrong. Please, relogin.")
            return
        }
        UserManager.shared.setField(userId: id, dict: dict).done { _ in
            self.coordinator?.popModule(completion: nil)
            NotificationCenter.default.post(name: GlobalConstants.userInfoChangeNotificationName, object: nil)
        } .catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
        
    }
}
