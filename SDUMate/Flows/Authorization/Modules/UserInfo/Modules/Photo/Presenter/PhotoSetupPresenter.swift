//
//  PhotoSetupPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import Foundation

protocol IPhotoSetupPresenter: AnyObject {
    func backTapped()
    func addPhotoTapped()
    func skipForNowTapped()
}

final class PhotoSetupPresenter: IPhotoSetupPresenter {
    
    weak var view: IPhotoSetupView?
    private weak var coordinator: IUserInfoSetupCoordinator?
    private let userInfo: UserInfo
    
    init(view: IPhotoSetupView, coordinator: IUserInfoSetupCoordinator, userInfo: UserInfo) {
        self.view = view
        self.coordinator = coordinator
        self.userInfo = userInfo
        print(userInfo)
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func addPhotoTapped() {
        
    }
    
    func skipForNowTapped() {
        
    }
}
