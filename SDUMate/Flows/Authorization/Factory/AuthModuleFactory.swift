//
//  AuthModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Foundation

final class AuthModuleFactory {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeEntryCoordinator() -> IEntryCoordinator {
        let navigationController = CoordinatorNavigationController()
        let coordinator = EntryCoordinator(router: Router(navigationController: navigationController))
        return coordinator
    }
    
    func makeEntryView(coordinator: IAuthCoordinator) -> IEntryView & Presentable {
        let view: IEntryView = EntryViewController()
        let presenter: IEntryPresenter = EntryPresenter(coordinator: coordinator, view: view)
        view.presenter = presenter
        return view
    }
    
    func makeLoginView(coordinator: IAuthCoordinator) -> ILoginView & Presentable {
        let view: ILoginView = LoginViewController()
        let presenter: ILoginPresenter = LoginPresenter(coordinator: coordinator, view: view)
        view.presenter = presenter
        return view
    }
    
    func makeUserInfoSetupFlow(navController: CoordinatorNavigationController) -> (Coordinator & IUserInfoSetupCoordinator) {
        let coordinator = UserInfoSetupCoordinator(router: Router(navigationController: navController))
        return coordinator
    }
    
    func makeAccountChoiceView(coordinator: IAuthCoordinator) -> IAccountChoiceView {
        let view: IAccountChoiceView = AccountChoiceViewController()
        let presenter: IAccountChoicePresenter = AccountChoicePresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makeStudentSignUpView(coordinator: IAuthCoordinator) -> IStudentSignUpView {
        let view: IStudentSignUpView = StudentSignUpViewController()
        let presenter: IStudentSignUpPresenter = StudentSignUpPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
}
