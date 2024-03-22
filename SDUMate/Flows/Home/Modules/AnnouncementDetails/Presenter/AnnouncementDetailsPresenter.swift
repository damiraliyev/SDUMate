//
//  AnnouncementDetailsPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol IAnnouncementDetailsPresenter: AnyObject {
    var onBackTapped: Completion? { get set }
}

final class AnnouncementDetailsPresenter: IAnnouncementDetailsPresenter {
    weak var view: IAnnouncementDetailsView?
    private let coordinator: IHomeCoordinator?
    
    var onBackTapped: Completion?
    
    init(view: IAnnouncementDetailsView, coordinator: IHomeCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
