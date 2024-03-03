//
//  PhotoSetupPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import Foundation

protocol IPhotoSetupPresenter: AnyObject {
    
}

final class PhotoSetupPresenter: IPhotoSetupPresenter {
    
    weak var view: IPhotoSetupView?
    private weak var coordinator: IUserInfoSetupCoordinator?
    
    init(view: IPhotoSetupView, coordinator: IUserInfoSetupCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
