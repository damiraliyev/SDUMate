//
//  DescriptionSetupPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 31.03.2024.
//

import Foundation

protocol IDescriptionSetupPresenter: AnyObject {
    func backTapped()
    func continueTapped(description: String)
    func viewDidLoad()
    func cancelTapped()
}

final class DescriptionSetupPresenter: IDescriptionSetupPresenter {
    weak var view: IDescriptionSetupView?
    private weak var coordinator: INewRequestCoordinator?
    private var announcement: Announcement
    
    init(announcement: Announcement, view: IDescriptionSetupView, coordinator: INewRequestCoordinator) {
        self.announcement = announcement
        self.view = view
        self.coordinator = coordinator
        print("Announcement", announcement)
    }
    
    func viewDidLoad() {
        view?.configure(category: announcement.category)
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func continueTapped(description: String) {
        guard !description.isEmpty else {
            view?.showError(error: "Field is required")
            return
        }
        announcement.description = description
        coordinator?.showPriceSetupView(announcement: announcement)
    }
    
    func cancelTapped() {
        let alertInput = AlertInput(title: "Confirm", message: "Are you sure you want to do this?", cancelTitle: "No", actionTitle: "Yes") {
            self.coordinator?.popToRoot()
        }
        coordinator?.presentAlert(input: alertInput)
    }
}
