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
    func cancelTapped()
}

final class RequestSummaryPresenter: IRequestSummaryPresenter {
    
    weak var view: IRequestSummaryView?
    private weak var coordinator: INewPostCoordinator?
    private var announcement: Announcement
    
    init(announcement: Announcement, view: IRequestSummaryView, coordinator: INewPostCoordinator) {
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
    
    func cancelTapped() {
        let alertInput = AlertInput(title: "Confirm", message: "Are you sure you want to do this?", cancelTitle: "No", actionTitle: "Yes") {
            self.coordinator?.popToRoot()
        }
        coordinator?.presentAlert(input: alertInput)
    }
}
