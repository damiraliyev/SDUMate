//
//  AuthCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Foundation

protocol IAuthCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    
    func onBackTapped(completion: Completion?)
    func showSignInView()
    func showHome()
    func showUserInfoSetup()
    func showAccountChoiceView()
    func showStudentSignUpView()
    func showAlumniSignUpView()
    func showErrorAlert(errorMessage: String)
    func showAlert(input: AlertInput)
    func showSuccessAlert(action: (() -> Void)?)
    func showVerificationSentView()
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
        let accountChoiceView = moduleFactory.makeAccountChoiceView(coordinator: self)
        router.present(accountChoiceView, animated: true, presentType: .panModal)
    }
    
    func showStudentSignUpView() {
        let studentSignUpView = moduleFactory.makeStudentSignUpView(coordinator: self)
        router.dismissPresentedView()
        router.push(studentSignUpView)
    }
    
    func showAlumniSignUpView() {
        let alumniSignUpView = moduleFactory.makeAlumniSignUpView(coordinator: self)
        router.dismissPresentedView()
        router.push(alumniSignUpView)
    }
    
    func showErrorAlert(errorMessage: String) {
        router.showErrorAlert(error: errorMessage)
    }
    
    override func showAlert(input: AlertInput) {
        router.showAlert(input: input)
    }
    
    func showSuccessAlert(action: (() -> Void)?) {
        let input = AlertInput(title: "Success", message: "Verification message was sent to your email. Please, verify it.", actionTitle: "Ok", actionCallBack: action)
        router.showAlertWithoutCancel(input: input, style: .default)
    }
    
    func showVerificationSentView() {
        let view = VerificationSentViewController()
        view.delegate = self
        router.push(view)
    }
}

extension AuthCoordinator: VerificationSentViewDelegate {
    func continueTapped() {
        router.popToRootModule()
        guard let navigationController = router.navigationController else { return }
        for view in navigationController.viewControllers {
            guard (view as? EntryViewController) == nil else { return }
            navigationController.viewControllers.removeAll { view in
                view as? EntryViewController == nil
            }
        }
    }
}
