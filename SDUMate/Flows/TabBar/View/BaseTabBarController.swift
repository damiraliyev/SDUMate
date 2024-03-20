//
//  BaseTabBarController.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 11.07.2023.
//

import UIKit

class BaseTabBarController: UITabBarController {
    var roundedView: UIView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setValue(BaseTabBar(), forKey: GlobalConstants.tabBarKey)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureTabBarImageInsets()
    }
    
    private func setupViews() {
        UITabBar.appearance().backgroundColor = .beProWhite
        let appearance = tabBar.standardAppearance
        appearance.stackedLayoutAppearance.normal.iconColor = .beProBlack
        appearance.stackedLayoutAppearance.selected.iconColor = .beProBlack
        tabBar.standardAppearance = appearance
        tabBar.layer.shadowColor = UIColor.moduleDescription.withAlphaComponent(0.3).cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: -1.0)
        tabBar.layer.shadowOpacity = 0.8
        tabBar.layer.shadowRadius = 1.0
    }
    
    func configureBackgroundView() {
        guard let numberOfItems = tabBar.items?.count else { return }
        let lineWidth = tabBar.frame.width / CGFloat(numberOfItems)
        let size: CGFloat = 56
        let yPosition = tabBar.bounds.minY + 8
        let roundedViewHeight = size
        roundedView = UIView(frame: CGRect(x: 0, y: yPosition, width: size, height: roundedViewHeight))
        roundedView?.backgroundColor = .bpSecondaryWhite
        roundedView?.layer.cornerRadius = 20
        
        if let selectedIdx = tabBar.items?.firstIndex(of: tabBar.selectedItem!) {
            roundedView?.center.x = lineWidth * (CGFloat(selectedIdx) + 0.5)
        }
        
        if let roundedView = roundedView {
            tabBar.addSubview(roundedView)
        }
    }
    
    func configureTabBarImageInsets() {
        let tabBarHeight = GlobalConstants.tabBarHeight
        let roundedViewHeight: CGFloat = 56
        let verticalSpace = tabBarHeight - roundedViewHeight
        let topInset: CGFloat = Device.hasHomeIndicator ? (verticalSpace / 2) + 4 : 2
        let bottomInset = Device.hasHomeIndicator ? (verticalSpace / 2) + 8 : 4
        let insets = UIEdgeInsets(top: topInset, left: 0, bottom: -bottomInset, right: 0)
        tabBar.items?.forEach { $0.imageInsets = insets }
    }
    
    func animateTabBarBackgroundView(tabBar: UITabBar, item: UITabBarItem?, index: Int?) {
        UIView.animate(withDuration: 0.15) {
            var selectedIndex = 0
            if let index = index {
                selectedIndex = index
            } else {
                guard let item = item else { return }
                selectedIndex = -(tabBar.items?.firstIndex(of: item)?.distance(to: 0))!
            }
            guard let itemView = tabBar.items?[selectedIndex].value(forKey: GlobalConstants.itemView) as? UIView else { return }
            self.roundedView?.center.x = itemView.frame.midX
        }
    }
}
