//
//  HomePresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 17.03.2024.
//

import Foundation
import PromiseKit

protocol IHomePresenter {
    var announcements: [Announcement] { get }
    
    func viewDidLoad()
    func filterTapped()
    func didSelectItem(at indexPath: IndexPath)
    func typeRemoved()
    func categoryRemoved(at indexPath: IndexPath)
}

final class HomePresenter: IHomePresenter {
    weak var view: IHomeView?
    private let coordinator: IHomeCoordinator?
    private let homeManager: HomeManager
    private var filter: AppliedFilter?
    let id = AuthManager.shared.getAuthUser()?.uid ?? ""
    var announcements: [Announcement] = [
    ]
    
    init(view: IHomeView, coordinator: IHomeCoordinator, homeManager: HomeManager) {
        self.view = view
        self.coordinator = coordinator
        self.homeManager = homeManager
    }
    
    func viewDidLoad() {
        fetchAnnouncements()
    }
    
    func filterTapped() {
        coordinator?.showFilterView(appliedFilter: filter, delegate: self)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let announcement = announcements[indexPath.row]
        coordinator?.showAnnouncementDetailsView(with: announcement)
    }
    
    func typeRemoved() {
        filter?.type = nil
    }
    
    func categoryRemoved(at indexPath: IndexPath) {
        filter?.categories.remove(at: indexPath.row)
    }
    
    private func fetchAnnouncements() {
        firstly {
            homeManager.fetchCompleteAnnouncements()
        } .done { announcements in
            self.announcements = announcements
            self.view?.reload()
        } .catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
}

extension HomePresenter: HomeHeaderViewDelegate {
    func notificationsTapped() {
        coordinator?.showInvitationsView()
    }
    
    func profileTapped() {
        coordinator?.showProfileView()
    }
}

extension HomePresenter: FilterViewDelegate {
    func filtersApplied(filter: AppliedFilter) {
        self.filter = filter
        view?.configureAppliedFilters(with: filter)
    }
}
