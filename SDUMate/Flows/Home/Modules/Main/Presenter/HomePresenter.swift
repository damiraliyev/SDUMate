//
//  HomePresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 17.03.2024.
//

import Foundation
import PromiseKit

protocol IHomePresenter {
    var announcementsDataSource: [Announcement] { get }
    
    func viewDidLoad()
    func filterTapped()
    func didSelectItem(at indexPath: IndexPath)
    func typeRemoved()
    func categoryRemoved(at indexPath: IndexPath)
}

final class HomePresenter: IHomePresenter {
    weak var view: IHomeView?
    private weak var coordinator: IHomeCoordinator?
    private let homeManager: HomeManager
    private var filter: AppliedFilter?
    let id = AuthManager.shared.getAuthUser()?.uid ?? ""
    private var announcements: [Announcement] = []
    var announcementsDataSource: [Announcement] = []
    
    init(view: IHomeView, coordinator: IHomeCoordinator, homeManager: HomeManager) {
        self.view = view
        self.coordinator = coordinator
        self.homeManager = homeManager
    }
    
    func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(userInfoChanged), name: GlobalConstants.userInfoChangeNotificationName, object: nil)
        fetchAnnouncements()
        fetchUser()
    }
    
    func filterTapped() {
        coordinator?.showFilterView(appliedFilter: filter, delegate: self)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let announcement = announcementsDataSource[indexPath.row]
        coordinator?.showAnnouncementDetailsView(with: announcement)
    }
    
    func typeRemoved() {
        filter?.type = nil
        filtrateAnnouncements()
    }
    
    func categoryRemoved(at indexPath: IndexPath) {
        if filter?.type != nil {
            filter?.categories.remove(at: indexPath.row - 1)
        } else {
            filter?.categories.remove(at: indexPath.row)
        }
        filtrateAnnouncements()
    }
    
    private func fetchAnnouncements() {
        firstly {
            homeManager.fetchCompleteAnnouncements()
        } .done { announcements in
            self.announcements = announcements
            self.announcementsDataSource = announcements
            self.view?.reload()
        } .catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
    
    private func fetchUser() {
        homeManager.getUser(userId: id).done { [weak self] user in
            let fullName = "\(user.name ?? "") \(user.surname ?? "")"
            let nickname = user.nickname ?? ""
            self?.view?.setupHeader(fullName: fullName, nickname: nickname, avatarUrl: user.profileImageUrl)
        } .catch { [weak self] error in
            self?.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
    
    private func filtrateAnnouncements() {
        announcementsDataSource = announcements
        guard let filter = filter else {
            announcementsDataSource = announcements
            view?.reload()
            return
        }
        if let type = filter.type {
            announcementsDataSource = announcements.filter({ $0.type == type })
            print("ANNOUNCEMENT DATA SOURCE", announcementsDataSource)
        } else {
            announcementsDataSource = announcements
        }
        if !filter.categories.isEmpty {
            announcementsDataSource = announcementsDataSource.filter {
                filter.categories.contains($0.category)
            }
        }
        view?.reload()
    }
    
    @objc func userInfoChanged() {
        UserManager.shared.getUser(userId: id).done { dbUser in
            let fullName = "\(dbUser.name ?? "") \(dbUser.surname ?? "")"
            self.view?.setupHeader(fullName: fullName, nickname: dbUser.nickname ?? "", avatarUrl: nil)
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
        filtrateAnnouncements()
        view?.configureAppliedFilters(with: filter)
    }
}
