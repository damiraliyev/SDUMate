//
//  SessionsPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol ISessionsPresenter: AnyObject {
    var dataSource: [Announcement] { get }
    
    func typeTapped(type: SessionSelection)
    func didSelectItem(at indexPath: IndexPath)
}

final class SessionsPresenter: ISessionsPresenter {
    
    weak var view: ISessionsView?
    private weak var coordinator: ISessionsCoordinator?
    
    private var announcements = [
        Announcement(category: "Software Engineering", title: "Object oriented programming", description: "Object-oriented programming (OOP) is a computer programming model that organizes software design around data, or objects, rather than functions and logic. An object can be defined as a data field that has unique attributes and behavior.", announcer: "mntn7", rating: "5/5", reviewsCount: 55, price: "FREE", creationDate: Date(), isSessionEstablished: false, sessionEstablishedDate: Date(), recipient_id: "Bekzhan Zhakas", type: "Request"),
        Announcement(category: "Software Engineering", title: "Unit testing iOS", description: "Unit testing is the process where you test the smallest functional unit of code. Software testing helps ensure code quality, and it's an integral part of software development.", announcer: "bekzhan", rating: "5/5", reviewsCount: 50, price: "5000 ₸", creationDate: Date(), isSessionEstablished: false, sessionEstablishedDate: Date(), recipient_id: "Bekzhan Zhakas", type: "Offer"),
        Announcement(category: "Software Engineering", title: "Swift UI", description: "SwiftUI is an innovative, exceptionally simple way to build user interfaces across all Apple platforms with the power of Swift.", announcer: "mntn7", rating: "5/5", reviewsCount: 55, price: "10 000 ₸", creationDate: Date(), isSessionEstablished: false, sessionEstablishedDate: Date(), recipient_id: "Bekzhan Zhakas", type: "Request"),
        Announcement(category: "Software Engineering", title: "Swift concurrency", description: "The concurrency model in Swift is built on top of threads, but you don't interact with them directly.", announcer: "mntn7", rating: "5/5", reviewsCount: 55, price: "FREE", creationDate: Date(), isSessionEstablished: false, sessionEstablishedDate: Date(), recipient_id: "Cristiano Ronaldo", type: "Offer")
    ]
    
    lazy var dataSource: [Announcement] = announcements
    
    init(view: ISessionsView, coordinator: ISessionsCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func typeTapped(type: SessionSelection) {
        switch type {
        case .all:
            dataSource = announcements
        case .offer:
            dataSource = announcements.filter { $0.type == "Offer" }
        case .request:
            dataSource = announcements.filter { $0.type == "Request" }
        case .collaborate:
            dataSource = announcements.filter { $0.type == "Collaborate" }
        }
        configureEmptyStateIfNeeded()
        view?.reload()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let announcement = dataSource[indexPath.row]
        coordinator?.showAnnouncementDetailsView(with: announcement)
    }
    
    private func configureEmptyStateIfNeeded() {
        if dataSource.isEmpty {
            view?.showEmptyState()
        } else {
            view?.hideEmptyState()
        }
    }
}

