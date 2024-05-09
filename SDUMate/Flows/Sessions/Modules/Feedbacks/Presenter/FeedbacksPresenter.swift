//
//  FeedbacksPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.04.2024.
//

import Foundation

protocol IFeedbacksPresenter: AnyObject {
    func backTapped()
    func viewDidLoad()
    func numOfRows() -> Int
    func feedback(for indexPath: IndexPath) -> Feedback
}

final class FeedbacksPresenter: IFeedbacksPresenter {
    
    weak var view: IFeedbacksView?
    private weak var coordinator: IAnnouncementResponderInfoCoordinator?
    private let userId: String
    private var feedbacks: [Feedback] = []
    init(view: IFeedbacksView, coordinator: IAnnouncementResponderInfoCoordinator, userId: String) {
        self.view = view
        self.coordinator = coordinator
        self.userId = userId
    }
    
    func viewDidLoad() {
        fetchFeedbacks()
    }
    
    private func fetchFeedbacks() {
        UserManager.shared.fetchFeedbacks(userId: userId).done { feedbacks in
            self.feedbacks = feedbacks
            self.view?.reload()
            self.showEmptyStateIfNeeded()
        }.catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
    
    func backTapped() {
        self.coordinator?.onBackTapped(completion: nil)
    }
    
    func numOfRows() -> Int {
        return feedbacks.count
    }
    
    func feedback(for indexPath: IndexPath) -> Feedback {
        return feedbacks[indexPath.row]
    }
    
    func showEmptyStateIfNeeded() {
        if feedbacks.isEmpty {
            view?.showEmptyState()
        } else {
            view?.hideEmptyState()
        }
    }
}
