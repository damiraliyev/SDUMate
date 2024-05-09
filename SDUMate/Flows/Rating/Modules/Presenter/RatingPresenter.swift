//
//  RatingPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol IRatingPresenter: AnyObject {
    var usersDataSource: [DBUser] { get }
    func viewDidLoad()
    func topContributorTapped(type: TopContributorType, place: Int)
}

final class RatingPresenter: IRatingPresenter {
    weak var view: IRatingView?
    private weak var coordinator: IRatingCoordinator?
    
    private var users: [DBUser] = []
    var usersDataSource: [DBUser] = []
    
    
    init(view: IRatingView, coordinator: IRatingCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        fethcUsers()
    }
    
    func topContributorTapped(type: TopContributorType, place: Int) {
        guard let user = users[safe: place - 1] else { return }
        coordinator?.showTopContrubitorInfoView(user: user, type: type, place: place)
    }
    
    private func fethcUsers() {
        view?.showLoading()
        RatingManager.shared.fetchAllUsers().done { [weak self] users in
            self?.users = users.filter({ $0.isFullyAuthorized})
                .sorted(by: { $0.points > $1.points })
            self?.configureRating()
            self?.view?.hideLoading()
        } .catch { [weak self] error in
            self?.coordinator?.showErrorAlert(error: error.localizedDescription)
            self?.view?.hideLoading()
        }
    }
    
    private func configureRating() {
        let tops = Array(users.prefix(upTo: 3))
        view?.configureTops(goldUser: tops[safe: 0], silverUser: tops[safe: 1], bronzeUser: tops[safe: 2])
        if tops.count == 3 {
            usersDataSource = Array(users.suffix(from: 3))
            view?.reload()
        }
    }
}
