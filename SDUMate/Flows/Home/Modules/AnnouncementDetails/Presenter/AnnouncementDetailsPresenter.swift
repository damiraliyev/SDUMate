//
//  AnnouncementDetailsPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol IAnnouncementDetailsPresenter: AnyObject {
    func backTapped()
}

final class AnnouncementDetailsPresenter: IAnnouncementDetailsPresenter {
    weak var view: IAnnouncementDetailsView?
    private weak var coordinator: IHomeCoordinator?
    
    init(view: IAnnouncementDetailsView, coordinator: IHomeCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
}
