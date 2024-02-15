//
//  SceneDelegate.swift
//  SDUMate
//
//  Created by Damir Aliyev on 11.02.2024.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var assembler = Assembler([DependencyContainerAssembly()])
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = CoordinatorNavigationController()
        navigationController.navigationBar.isHidden = true
        appCoordinator = AppCoordinator(router: Router(navigationController: navigationController), container: assembler.resolver)
        appCoordinator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            window?.overrideUserInterfaceStyle = .dark
        }
    }
}

