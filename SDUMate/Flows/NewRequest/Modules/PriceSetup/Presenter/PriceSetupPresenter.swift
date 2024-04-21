//
//  PriceSetupPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 01.04.2024.
//

import Foundation

protocol IPriceSetupPresenter: AnyObject {
    func backTapped()
    func continueTapped(price: String, conditionIndex: Int)
    func cancelTapped()
}

final class PriceSetupPresenter: IPriceSetupPresenter {
    
    weak var view: IPriceSetupView?
    private weak var coordinator: INewRequestCoordinator?
    private var announcement: Announcement
    
    init(announcement: Announcement, view: IPriceSetupView, coordinator: INewRequestCoordinator) {
        self.announcement = announcement
        self.view = view
        self.coordinator = coordinator
        print("Announcement", announcement)
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func continueTapped(price: String, conditionIndex: Int) {
        let conditions = ["price", "free", "negotiable"]
        if (price.isEmpty && (conditionIndex == 0)) || price.hasPrefix("0") {
            return
        }
        if conditionIndex == 0 {
            announcement.price = price + " ₸"
        } else {
            announcement.price = conditions[conditionIndex]
        }
        coordinator?.showRequestSummaryView(announcement: announcement)
    }
    
    func cancelTapped() {
        let alertInput = AlertInput(title: "Confirm", message: "Are you sure you want to do this?", cancelTitle: "No", actionTitle: "Yes") {
            self.coordinator?.popToRoot()
        }
        coordinator?.presentAlert(input: alertInput)
    }
}
