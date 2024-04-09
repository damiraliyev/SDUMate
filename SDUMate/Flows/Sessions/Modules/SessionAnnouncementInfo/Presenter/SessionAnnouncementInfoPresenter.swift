//
//  SessionAnnouncementInfoPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 09.04.2024.
//

import Foundation

protocol ISessionAnnouncementInfoPresenter: AnyObject {
    
}

final class SessionAnnouncementInfoPresenter: ISessionAnnouncementInfoPresenter {
    
    weak var view: ISessionAnnouncementInfoView?
    private weak var coordinator: ISessionsCoordinator?
    
    init(view: ISessionAnnouncementInfoView, coordinator: ISessionsCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
