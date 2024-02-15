//
//  CoordinatorNavigationController.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 06.07.2023.
//

import UIKit
import PanModal

protocol CoordinatorNavigationControllerDelegate: AnyObject {}

class CoordinatorNavigationController: UINavigationController {
    private var isPushBeingAnimated = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setNavigationBarHidden(true, animated: false)
        delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
    }
    
    func enableSwipeBack() {
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
    }
    
    func disableSwipeBack() {
        interactivePopGestureRecognizer?.isEnabled = false
        interactivePopGestureRecognizer?.delegate = nil
    }
}

extension CoordinatorNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? CoordinatorNavigationController else { return }
        swipeNavigationController.isPushBeingAnimated = false
    }
}

extension CoordinatorNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else { return true }
        return viewControllers.count > 1 && isPushBeingAnimated == false
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

// MARK: - Pan Modal Presentable

extension CoordinatorNavigationController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        (topViewController as? PanModalPresentable)?.panScrollable
    }
    
    var topOffset: CGFloat {
        (topViewController as? PanModalPresentable)?.topOffset ?? .zero
    }
    
    var showDragIndicator: Bool {
        (topViewController as? PanModalPresentable)?.showDragIndicator ?? false
    }
    
    var shortFormHeight: PanModalHeight {
        (topViewController as? PanModalPresentable)?.shortFormHeight ?? .intrinsicHeight
    }
    
    var longFormHeight: PanModalHeight {
        (topViewController as? PanModalPresentable)?.longFormHeight ?? .intrinsicHeight
    }
    
    var allowsTapToDismiss: Bool {
        (topViewController as? PanModalPresentable)?.allowsTapToDismiss ?? true
    }
    
    var allowsDragToDismiss: Bool {
        (topViewController as? PanModalPresentable)?.allowsTapToDismiss ?? true
    }
    
    var cornerRadius: CGFloat {
        (topViewController as? PanModalPresentable)?.cornerRadius ?? 24
    }
    
    var shouldRoundTopCorners: Bool {
        (topViewController as? PanModalPresentable)?.shouldRoundTopCorners ?? true
    }
    
    var panModalBackgroundColor: UIColor {
        (topViewController as? PanModalPresentable)?.panModalBackgroundColor ?? .clear
    }
    
    func willTransition(to state: PanModalPresentationController.PresentationState) {
        (topViewController as? PanModalPresentable)?.willTransition(to: state)
    }
    
    func panModalWillDismiss() {
        (topViewController as? PanModalPresentable)?.panModalWillDismiss()
    }
    
    func panModalDidDismiss() {
        (topViewController as? PanModalPresentable)?.panModalWillDismiss()
    }
    
    func willRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) {
        (topViewController as? PanModalPresentable)?.willRespond(to: panModalGestureRecognizer)
    }
    
    func shouldTransition(to state: PanModalPresentationController.PresentationState) -> Bool {
        (topViewController as? PanModalPresentable)?.shouldTransition(to: state) ?? false
    }
}
