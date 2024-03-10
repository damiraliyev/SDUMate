//
//  AboutSetupPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import Foundation

protocol IAboutSetupPresenter: AnyObject {
    func backTapped()
    func continueTapped()
}

final class AboutSetupPresenter: IAboutSetupPresenter {
    
    weak var view: IAboutSetupView?
    private weak var coordinator:  IUserInfoSetupCoordinator?
    
    private var name = ""
    private var surname = ""
    private var nickname = ""
    private var telegramTag = ""
    
    init(view: IAboutSetupView, coordinator: IUserInfoSetupCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped() {
            self.coordinator?.onFlowDidFinish?()
        }
    }
    
    func continueTapped() {
        let userInfo = assembleUserInfo()
        coordinator?.showStudySetupView(userInfo: userInfo)
    }
    
    private func assembleUserInfo() -> UserInfo {
        let userInfo = UserInfo()
        userInfo.name = name
        userInfo.surname = surname
        userInfo.nickname = nickname
        userInfo.telegramTag = telegramTag
        return userInfo
    }
    
    private func verifyInfo() {
        let fields = [name, surname, nickname, telegramTag]
        let isAllFieldsWithValue = (fields.filter { !$0.isEmpty }).count == fields.count
        guard isAllFieldsWithValue else {
            view?.disableButton()
            return
        }
        view?.enableButton()
    }
}

extension AboutSetupPresenter: SMTextFieldViewDelegate {
    func textFieldDidChange(text: String, tag: Int) {
        let type = SMTextFieldTag(rawValue: tag)
        switch type {
        case .name:
            name = text
        case .surname:
            surname = text
        case .nickname:
            nickname = text
        case .telegramTag:
            telegramTag = text
        default:
            break
        }
        verifyInfo()
    }
}
