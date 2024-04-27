//
//  ProvideFeedbackPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 12.04.2024.
//

import Foundation
import PromiseKit

protocol IProvideFeedbackPresenter: AnyObject {
    func viewDidLoad()
    func doneTapped(comment: String)
    func starTapped(withTag tag: Int)
}

final class ProvideFeedbackPresenter: IProvideFeedbackPresenter {
    
    weak var view: IProvideFeedbackView?
    private weak var coordinator: ISessionsCoordinator?
    private let otherSide: DBUser
    private let session: Session
    private var providedStars = 0
    
    private let dispatchGroup = DispatchGroup()
    private var isAllRequestsSuccessful = true
    
    init(view: IProvideFeedbackView, coordinator: ISessionsCoordinator, otherSide: DBUser, session: Session) {
        self.view = view
        self.coordinator = coordinator
        self.otherSide = otherSide
        self.session = session
    }
    
    func viewDidLoad() {
        let fullName = "\(otherSide.name ?? "") \(otherSide.surname ?? "")"
        view?.configure(profileImageUrl: otherSide.profileImageUrl, fullName: fullName, title: session.announcement?.title ?? "")
    }
    
    func starTapped(withTag tag: Int) {
        providedStars = tag + 1
    }
    
    func doneTapped(comment: String) {
        dispatchGroup.enter()
        endSession()
        dispatchGroup.enter()
        sendFeedback(comment: comment)
        dispatchGroup.enter()
        updateUserRankingRates()
        
        dispatchGroup.notify(queue: .main) {
            guard self.isAllRequestsSuccessful else {
                self.coordinator?.showErrorAlert(error: "Something went wrong. Try again please")
                return
            }
            self.coordinator?.dismissModule(completion: nil)
        }
    }
    
    private func endSession() {
        guard let id = AuthManager.shared.getAuthUser()?.uid else { return }
        var status: SessionStatus
        if id == session.announcerId && session.status == .active {
            status = .announcerFinished
        } else if id == session.respondentId && session.status == .active {
            status = .responderFinished
        } else {
            status = .finished
        }
        SessionsManager.shared.endSession(sessionId: session.id, newStatus: status).done { [weak self] _ in
            self?.dispatchGroup.leave()
        }.catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
            self.dispatchGroup.leave()
            self.isAllRequestsSuccessful = false
        }
    }
    
    private func sendFeedback(comment: String) {
        guard let id = AuthManager.shared.getAuthUser()?.uid else { return }
        var reviewer: DBUser?
        if id == session.announcerId {
            reviewer = session.announcer
        } else {
            reviewer = session.respondent
        }
        guard let reviewer else { return }
        let feedback = Feedback(id: "", reviewerId: id, reviewer: reviewer, createdDate: Date().toString(), rating: Double(providedStars), description: comment)
        SessionsManager.shared.sendFeedback(userId: otherSide.userId, feedback: feedback).done { _ in
            self.dispatchGroup.leave()
        }.catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
            self.dispatchGroup.leave()
            self.isAllRequestsSuccessful = false
        }
    }
    
    private func updateUserRankingRates() {
        var newNumberOfProvidedHelp = otherSide.numberOfProvidedHelp
        if session.announcement?.type == .request && otherSide.userId == session.respondentId {
            newNumberOfProvidedHelp += 1
        }
        let additionalPoints = switch providedStars {
        case 5: 7
        case 4: 5
        case 3: 0
        case 2: -2
        case 1: -3
        case 0: -5
        default: -7
        }
        let newPoints = otherSide.points + additionalPoints
        let newReviewsCount = otherSide.reviewsCount + 1
        let ratingsSum = (otherSide.rating * Double(newReviewsCount) + Double(providedStars))
        let newRating = ratingsSum / Double(newReviewsCount + 1)
        SessionsManager.shared.updateUserRankingRates(userId: otherSide.userId, newRating: newRating, newReviewsCount: newReviewsCount, newNumberOfProvidedHelp: newNumberOfProvidedHelp, newPoints: newPoints).done { _ in
            self.dispatchGroup.leave()
        } .catch { error in
            self.isAllRequestsSuccessful = false
            self.dispatchGroup.leave()
        }
    }
    
}
