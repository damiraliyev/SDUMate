//
//  UIView+Extensions.swift
//  BeProTest
//
//  Created by Yessenali Zhanaidar on 03.07.2023.
//

import UIKit
import SnapKit

public enum GradientType {
    case gold
    case silver
    case bronze
    
    var colors: [CGColor] {
        switch self {
        case .gold:
            return [
                UIColor(hex: 0xFFFA82).cgColor,
                UIColor(hex: 0xE9AB1C).cgColor,
                UIColor(hex: 0xF9E15B).cgColor,
                UIColor(hex: 0xE9AB1C).cgColor
            ]
        case .silver:
            return [UIColor(hex: 0xF5F8FF).cgColor,
                    UIColor(hex: 0x93A1A9).cgColor,
                    UIColor(hex: 0xCCDBE3).cgColor,
                    UIColor(hex: 0x93A1A9).cgColor
            ]
        case .bronze:
            return [UIColor(hex: 0xFFB649).cgColor,
                    UIColor(hex: 0xA56F1F).cgColor,
                    UIColor(hex: 0xFFCB7C).cgColor,
                    UIColor(hex: 0xA56F1F).cgColor
            ]}
    }
}


extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}

extension UIView {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let seScreenHeight: CGFloat = 568
    static let SevenScreenHeight: CGFloat = 667
    static var safeBottomAreaHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }
    static var safeTopAreaHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        } else {
            return 0
        }
    }
    
    var safeArea: ConstraintBasicAttributesDSL {
        return self.safeAreaLayoutGuide.snp
    }
    
    func applyGradient(forGradientType type: GradientType?) {
        if let existingGradient = self.layer.sublayers?.first as? CAGradientLayer {
            existingGradient.frame = self.bounds
            existingGradient.cornerRadius = self.layer.cornerRadius
        } else {
            let gradientLayer = CAGradientLayer()
            gradientLayer.cornerRadius = self.layer.cornerRadius
            gradientLayer.colors = type?.colors
            gradientLayer.locations = [0, 0, 0.54, 1]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.transform = CATransform3DMakeAffineTransform(
                CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
            gradientLayer.frame = self.bounds
            gradientLayer.position = self.center
            self.layer.insertSublayer(gradientLayer, at: 0)
            self.layer.masksToBounds = true
        }
    }
    
    func removeFromSuperview(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = 0
            }) { _ in
                self.removeFromSuperview()
            }
        } else {
            self.removeFromSuperview()
        }
    }
    
    /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
    /// https://stackoverflow.com/a/45297466/5321670
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}

extension UIView {
    func safeHide() {
        if isHidden { return }
        isHidden = true
    }
    
    func safeShow() {
        if !isHidden { return }
        isHidden = false
    }
}

extension UIView {
    enum AnimationEdge {
        case none
        case top
        case bottom
        case left
        case right
    }

    @discardableResult
    func showFromStack(duration: TimeInterval = 0.25,
                       delay: TimeInterval = 0,
                       completion: ((Bool) -> Void)? = nil) -> UIView {
        UIView.animate(
            withDuration: duration, delay: delay, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.isHidden = false
                self.alpha = 1
            }, completion: completion)
        return self
    }

    @discardableResult
    func hideFromStack(duration: TimeInterval = 0.25,
                       delay: TimeInterval = 0,
                       completion: ((Bool) -> Void)? = nil) -> UIView {
        if self.isHidden != true {
            UIView.animate(
                withDuration: duration, delay: delay, options: .allowAnimatedContent, animations: {
                    self.isHidden = true
                    self.alpha = 0
                }, completion: completion)
        }
        return self
    }

    @discardableResult
    func fadeIn(duration: TimeInterval = 0.25,
                delay: TimeInterval = 0,
                completion: ((Bool) -> Void)? = nil) -> UIView {
        isHidden = false
        alpha = 0
        UIView.animate(
            withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
                self.alpha = 1
            }, completion: completion)
        return self
    }

    @discardableResult
    func fadeOut(duration: TimeInterval = 0.25,
                 delay: TimeInterval = 0,
                 completion: ((Bool) -> Void)? = nil) -> UIView {
        UIView.animate(
            withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
                self.alpha = 0
            }, completion: completion)
        return self
    }

    @discardableResult
    func fadeColor(toColor: UIColor = UIColor.red,
                   duration: TimeInterval = 0.25,
                   delay: TimeInterval = 0,
                   completion: ((Bool) -> Void)? = nil) -> UIView {
        UIView.animate(
            withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
                self.backgroundColor = toColor
            }, completion: completion)
        return self
    }

    @discardableResult
    func slideIn(from edge: AnimationEdge = .none,
                 x: CGFloat = 0,
                 y: CGFloat = 0,
                 duration: TimeInterval = 0.4,
                 delay: TimeInterval = 0,
                 completion: ((Bool) -> Void)? = nil) -> UIView {
        let offset = offsetFor(edge: edge)
        transform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
        isHidden = false
        UIView.animate(
            withDuration: duration, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 2,
            options: .curveEaseOut, animations: {
                self.transform = .identity
                self.alpha = 1
            }, completion: completion)
        return self
    }

    @discardableResult
    func slideOut(to edge: AnimationEdge = .none,
                         x: CGFloat = 0,
                         y: CGFloat = 0,
                         duration: TimeInterval = 0.25,
                         delay: TimeInterval = 0,
                         completion: ((Bool) -> Void)? = nil) -> UIView {
        let offset = offsetFor(edge: edge)
        let endTransform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
        UIView.animate(
            withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
                self.transform = endTransform
            }, completion: completion)
        return self
    }
    
    private func offsetFor(edge: AnimationEdge) -> CGPoint {
        if let parentSize = self.superview?.frame.size {
            switch edge {
            case .none: return CGPoint.zero
            case .top: return CGPoint(x: 0, y: -frame.maxY)
            case .bottom: return CGPoint(x: 0, y: parentSize.height - frame.minY)
            case .left: return CGPoint(x: -frame.maxX, y: 0)
            case .right: return CGPoint(x: parentSize.width - frame.minX, y: 0)
            }
        }
        return .zero
    }
}

extension UIView {
    private static let kLayerNameGradientBorder = "GradientBorderLayer"
    
    public func setGradientBorder(width: CGFloat, colors: [UIColor],
                                  startPoint: CGPoint, endPoint: CGPoint) {
        let existedBorder = gradientBorderLayer()
        let border = existedBorder ?? CAGradientLayer()
        border.frame = self.bounds
        border.colors = colors.map(\.cgColor)
        border.startPoint = startPoint
        border.endPoint = endPoint
        border.name = UIView.kLayerNameGradientBorder
        
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: self.bounds,
                                 cornerRadius: self.bounds.size.height / 2).cgPath
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = width
        
        border.mask = mask
        
        let exists = existedBorder != nil
        if !exists {
            layer.addSublayer(border)
        }
    }
    
    public func removeGradientBorder() {
        self.gradientBorderLayer()?.removeFromSuperlayer()
    }
    
    private func gradientBorderLayer() -> CAGradientLayer? {
        let borderLayers = layer.sublayers?.filter { return $0.name == UIView.kLayerNameGradientBorder }
        if borderLayers?.count ?? 0 > 1 {
            fatalError()
        }
        return borderLayers?.first as? CAGradientLayer
    }
}

public extension UIView {

    struct ValuesHolder {
        static var tapClosures: [UIView: () -> Void] = [:]
    }
    
    var closure: () -> Void {
        get {
            return ValuesHolder.tapClosures[self] ?? {}
        }
        set(value) {
            ValuesHolder.tapClosures[self] = value
        }
    }

    func addTap(_ closure: @escaping () -> Void) {
        self.closure = closure
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.addGestureRecognizer(tap)
    }

    @objc private func tapped() {
        closure()
    }
}
