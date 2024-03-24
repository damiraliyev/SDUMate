//
//  HomePresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 17.03.2024.
//

import Foundation

protocol IHomePresenter {
    var announcements: [Announcement] { get }
    func filterTapped()
    func didSelectItem(at indexPath: IndexPath)
}

final class HomePresenter: IHomePresenter {
    weak var view: IHomeView?
    private let coordinator: IHomeCoordinator?
    private var filter: AppliedFilter?
    
    var announcements = [
        Announcement(category: "Software Engineering", title: "Object oriented programming", description: "Object-oriented programming (OOP) is a computer programming model that organizes software design around data, or objects, rather than functions and logic. An object can be defined as a data field that has unique attributes and behavior.", announcer: "mntn7", rating: "5/5", reviewsCount: 55, price: "FREE", creationDate: Date(), isSessionEstablished: false, sessionEstablishedDate: nil, recipient_id: nil, type: "Offer"),
        Announcement(category: "Software Engineering", title: "Unit testing iOS", description: "Unit testing is the process where you test the smallest functional unit of code. Software testing helps ensure code quality, and it's an integral part of software development.", announcer: "bekzhan", rating: "5/5", reviewsCount: 50, price: "5000 ₸", creationDate: Date(), isSessionEstablished: false, sessionEstablishedDate: nil, recipient_id: nil, type: "Request"),
        Announcement(category: "Software Engineering", title: "Swift UI", description: "SwiftUI is an innovative, exceptionally simple way to build user interfaces across all Apple platforms with the power of Swift.", announcer: "mntn7", rating: "5/5", reviewsCount: 55, price: "10 000 ₸", creationDate: Date(), isSessionEstablished: false, sessionEstablishedDate: nil, recipient_id: nil, type: "Request"),
        Announcement(category: "Software Engineering", title: "Swift concurrency", description: "The concurrency model in Swift is built on top of threads, but you don't interact with them directly.", announcer: "mntn7", rating: "5/5", reviewsCount: 55, price: "FREE", creationDate: Date(), isSessionEstablished: false, sessionEstablishedDate: nil, recipient_id: nil, type: "Offer")
    ]
    
    init(view: IHomeView, coordinator: IHomeCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func filterTapped() {
        coordinator?.showFilterView(appliedFilter: filter, delegate: self)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let announcement = announcements[indexPath.row]
        coordinator?.showAnnouncementDetailsView(with: announcement)
    }
}

extension HomePresenter: HomeHeaderViewDelegate {
    func notificationsTapped() {
        coordinator?.showInvitationsView()
    }
}

extension HomePresenter: FilterViewDelegate {
    func filtersApplied(filter: AppliedFilter) {
        self.filter = filter
        view?.configureAppliedFilters(with: filter)
    }
}
