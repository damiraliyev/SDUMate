//
//  SessionsCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

protocol ISessionsCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    
    func onBackTapped(completion: Completion?)
    func showOtherSideProfile(responder: DBUser, announcementDescription: String)
    func showAnnouncementDetailsView(with announcement: Announcement, announcer: DBUser, respondent: DBUser)
    func showEndSessionAlert(endAction: UIAlertAction, cancelAction: UIAlertAction)
    func showProvideFeedback(otherSide: DBUser, session: Session)
}

final class SessionsCoordinator: BaseCoordinator, TababbleCoordinator {
    var onOwnerTabBarNeedsToBeChanged: ((OwnerTabBarItem) -> Void)?
    var tabCoordinatorDelegate: TabCoordinatorDelegate?
    
    private let container: DependencyContainer
    private let moduleFactory: SessionsModuleFactory
    var onFlowDidFinish: Completion?
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        moduleFactory = SessionsModuleFactory(container: container)
        super.init(router: router)
    }
    
    override func start() {
        let sessionView = moduleFactory.makeSessionsView(coordinator: self)
        router.setRootModule(sessionView)
    }
}

extension SessionsCoordinator: ISessionsCoordinator {
    func onBackTapped(completion: Completion?) {
        router.popModule()
        completion?()
    }
    
    func showOtherSideProfile(responder: DBUser, announcementDescription: String) {
        let view = moduleFactory.makeResponderInfoView(responder: responder, announcementDescription: announcementDescription, coordinator: self)
        router.push(view)
    }
    
    func showAnnouncementDetailsView(with announcement: Announcement, announcer: DBUser, respondent: DBUser) {
        let announcementDetailsView = moduleFactory.makeAnnouncementDetailsView(announcement: announcement, announcer: announcer, respondent: respondent, coordinator: self)
        router.present(announcementDetailsView, animated: true, presentType: .panModal)
    }
    
    func showEndSessionAlert(endAction: UIAlertAction, cancelAction: UIAlertAction) {
        let alertController = UIAlertController(title: "Are you sure you want to do this?", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(endAction)
        let cancelAction = UIAlertAction(title: CoreL10n.cancel, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        router.presentAlert(alertController, animated: true)
    }
    
    func showProvideFeedback(otherSide: DBUser, session: Session) {
        let provideFeedbackView = moduleFactory.makeProvideFeedbackView(otherSide: otherSide, session: session, coordinator: self)
        router.present(provideFeedbackView, animated: true, presentType: .panModal)
    }
    
    func dismissModule(completion: (() -> Void)?) {
        router.dismissModule(completion: completion)
    }
}

extension SessionsCoordinator: IAnnouncementResponderInfoCoordinator {
    func showFeedbacks(userId: String) {
        let view = moduleFactory.makeFeedbacksView(userId: userId, coordinator: self)
        router.push(view)
    }
}
