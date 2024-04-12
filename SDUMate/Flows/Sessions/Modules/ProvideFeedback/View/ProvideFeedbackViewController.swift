//
//  ProvideFeedbackViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 12.04.2024.
//

import UIKit
import PanModal

protocol IProvideFeedbackView: Presentable {
    var presenter: IProfilePresenter? { get set }
}

final class ProvideFeedbackViewController: BaseViewController, IProvideFeedbackView {
    
    var presenter: IProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._2A2848
    }
    
    private func setupConstraints() {
        
    }
}

extension ProvideFeedbackViewController: PanModalPresentable {
    var panScrollable: UIScrollView? { nil }
    
    var cornerRadius: CGFloat { 16 }
    
    var shouldRoundTopCorners: Bool { true }
    
    var topOffset: CGFloat { .zero }
    
    var showDragIndicator: Bool { false }
    
    var allowsDragToDismiss: Bool { true }
    
    var isHapticFeedbackEnabled: Bool { false }
    
    var panModalBackgroundColor: UIColor { .dark.withAlphaComponent(0.4) }
    
    var longFormHeight: PanModalHeight {
        .contentHeight(UIView.screenHeight * 0.8)
    }
}
