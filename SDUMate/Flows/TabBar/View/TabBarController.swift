//
//  OnwerTabBarController.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 05.07.2023.
//

import UIKit

protocol TababbleCoordinator: BaseCoordinator {
    var onOwnerTabBarNeedsToBeChanged: ((_ toTabBarItem: OwnerTabBarItem) -> Void)? { get set }
    var tabCoordinatorDelegate: TabCoordinatorDelegate? { get set }
    var onFlowDidFinish: Completion? { get set }
}

protocol TabBarPresentable {
    func setViewControllers(_ viewControllers: [UIViewController])
    func changeSelectedTabBarItem(_ tabBarItem: OwnerTabBarItem, completion: (() -> Void)?)
}

final class TabBarController: BaseTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension TabBarController: TabBarPresentable {
    func setViewControllers(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        configureBackgroundView()
        tabBar.items?[0].selectedImage = Asset.icTabHome.image.withTintColor(.white)
        tabBar.items?[1].selectedImage = Asset.icTabSessions.image.withTintColor(.white)
        tabBar.items?[2].selectedImage = Asset.icTabNew.image.withTintColor(.white)
        tabBar.items?[3].selectedImage = Asset.icTabRating.image.withTintColor(.white)
        tabBar.items?[4].selectedImage = Asset.icTabProfile.image.withTintColor(.white)
    }
    
    func changeSelectedTabBarItem(_ tabBarItem: OwnerTabBarItem, completion: Completion?) {
        guard let viewController = viewControllers?[tabBarItem.index] else { return }
        selectedViewController = viewController
        completion?()
        animateTabBarBackgroundView(tabBar: self.tabBar, item: nil, index: tabBarItem.index)
        
    }
}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        animateTabBarBackgroundView(tabBar: tabBar, item: item, index: nil)
    }
}
