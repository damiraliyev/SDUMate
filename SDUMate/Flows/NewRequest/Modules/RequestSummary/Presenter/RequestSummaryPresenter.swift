//
//  RequestSummaryPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 01.04.2024.
//

import Foundation
import PromiseKit

protocol IRequestSummaryPresenter: AnyObject {
    func viewDidLoad()
    func backTapped()
    func postTapped()
}

final class RequestSummaryPresenter: IRequestSummaryPresenter {
    
    weak var view: IRequestSummaryView?
    private weak var coordinator: INewRequestCoordinator?
    private var announcement: Announcement
    
    init(announcement: Announcement, view: IRequestSummaryView, coordinator: INewRequestCoordinator) {
        self.announcement = announcement
        self.view = view
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        view?.configure(with: announcement)
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func postTapped() {
        guard let id = AuthManager.shared.getAuthUser()?.uid else { return }
        announcement.announcerId = id
        announcement.createdDate = Date().toString()
        AnnouncementManager.shared.post(announcement: announcement).done { _ in
            print("Posted successfully")
            self.coordinator?.router.popToRootModule()
        } .catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
}
