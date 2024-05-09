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
    
    private func fethcUsers() {
        view?.showLoading()
        RatingManager.shared.fetchAllUsers().done { [weak self] users in
            self?.users = users.sorted(by: { $0.points > $1.points })
            self?.configureRating()
            self?.view?.hideLoading()
        } .catch { [weak self] error in
            self?.coordinator?.showErrorAlert(error: error.localizedDescription)
            self?.view?.hideLoading()
        }
    }
    
    private func configureRating() {
        let tops = users.prefix(3)
        view?.configureTops(goldUser: tops[safe: 0], silverUser: tops[safe: 1], bronzeUser: tops[safe: 2])
        if tops.count == 3 {
            usersDataSource = users
            view?.reload()
        }
        
    }
}
