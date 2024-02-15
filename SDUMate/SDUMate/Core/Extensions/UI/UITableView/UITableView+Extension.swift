//
//  UITableView+Extension.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 10.07.2023.
//

import UIKit
import SkeletonView

extension UITableView {
    func register<T: UITableViewHeaderFooterView>(_: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }

    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(T.defaultReuseIdentifier)")
        }
        return view
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue table cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}

extension UITableViewHeaderFooterView: ReusableView { }
extension UITableViewCell: ReusableView { }

extension UITableView {
    func showLoadingFooter() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.tintColor = .dark
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.bounds.width, height: CGFloat(44))
        self.tableFooterView = spinner
        self.tableFooterView?.safeShow()
    }
    
    func hideLoadingFooter() {
        self.tableFooterView?.safeHide()
        self.tableFooterView = nil
    }
    
    func showSkeleton(skeletonColor: UIColor = .skeletonColor) {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        self.showAnimatedGradientSkeleton(
            usingGradient: SkeletonGradient(baseColor: skeletonColor),
            animation: animation,
            transition: .crossDissolve(0.25)
        )
    }
}

extension UITableView {
    func setupZeroHeaderInset() {
        self.contentInset.bottom = UIView.safeBottomAreaHeight
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        } else {
            self.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        }
    }
}
