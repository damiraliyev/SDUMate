//
//  AuthCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Foundation

protocol IAuthCoordinator: AnyObject {
    var onFlowDidFinish: Completion? { get set }
    
    func onBackTapped(completion: Completion?)
    func showSignInView()
    func showHome()
    func showUserInfoSetup()
    func showAccountChoiceView()
}

final class AuthCoordinator: BaseCoordinator, IAuthCoordinator {
    private let container: DependencyContainer
    private let moduleFactory: AuthModuleFactory
    private var entryView: IEntryView?
    var onFlowDidFinish: Completion?
    
    
    init(router: Router, container: DependencyContainer) {
        self.container = container
        moduleFactory = AuthModuleFactory(container: container)
        super.init(router: router)
    }
    
    override func start() {
        entryView = moduleFactory.makeEntryView(coordinator: self)
        router.push(entryView)
    }
    
    func onBackTapped(completion: Completion?) {
        router.popModule()
        completion?()
    }
    
    func showSignInView() {
        let loginView = moduleFactory.makeLoginView(coordinator: self)
        router.push(loginView, animated: true)
    }
    
    func showHome() {
        
    }
    
    func showUserInfoSetup() {
        guard let navigationController = router.navigationController else { return }
        let userInfoSetupCoordinator = moduleFactory.makeUserInfoSetupFlow(navController: navigationController)
        addDependency(userInfoSetupCoordinator)
        userInfoSetupCoordinator.onFlowDidFinish = { [weak self, weak userInfoSetupCoordinator] in
            guard let self else { return }
            removeDependency(userInfoSetupCoordinator)
        }
        userInfoSetupCoordinator.start()
    }
    
    func showAccountChoiceView() {
        let view = AccountChoiceViewController()
        router.present(view, animated: true, presentType: .panModal)
    }
}
