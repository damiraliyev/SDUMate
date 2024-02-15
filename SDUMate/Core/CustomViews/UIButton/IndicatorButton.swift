//
//  IndicatorButton.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 04.07.2023.
//

import UIKit

public final class IndicatorButton: UIButton {
    
    public enum Style {
        case inactive
        case active
        
        public var titleColor: UIColor {
            switch self {
            case .inactive:
                return .bpGray
            case .active:
                return .beProWhite
            }
        }
        
        public var backgroundColor: UIColor {
            switch self {
            case .inactive:
                return .bpSecondaryWhite
            case .active:
                return .dark
            }
        }
        
        public var isUserInteractionEnabled: Bool {
            switch self {
            case .inactive:
                return false
            case .active:
                return true
            }
        }
    }
    
    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .medium
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var loading: Bool = false {
        didSet {
            loading ? indicatorView.startAnimating() : indicatorView.stopAnimating()
            isActive = !loading
        }
    }
    
    public var isActive: Bool = true {
        didSet {
            isUserInteractionEnabled = isActive
            setTitleColor(isActive ? style.titleColor : style.titleColor.withAlphaComponent(0.2), for: .normal)
            
            if imageView?.image != nil {
                if titleLabel?.text == nil || titleLabel?.text?.isEmpty == true {
                    imageView?.layer.transform = isActive ? CATransform3DIdentity : CATransform3DMakeScale(0.0, 0.0, 0.0)
                } else {
                    let image = imageView?.image
                    isActive ? setImage(image, for: .normal) : setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
                    tintColor = isActive ? style.titleColor : style.titleColor.withAlphaComponent(0.2)
                }
            }
        }
    }
    
    public var style: Style = .active {
        didSet {
            backgroundColor = style.backgroundColor
            indicatorView.color = style.titleColor
            setTitleColor(style.titleColor, for: .normal)
            isActive = style.isUserInteractionEnabled
        }
    }
    
    public var indicatorColor: UIColor? {
        didSet {
            guard let color = indicatorColor else { return }
            indicatorView.color = color
        }
    }
    
    public var dumpable: Bool = true
    
    public init(_ title: String, style: Style = .active) {
        super.init(frame: .zero)
        self.style = style
        setTitle(title, for: .normal)
        setTitleColor(style.titleColor, for: .normal)
        backgroundColor = style.backgroundColor
        indicatorView.color = style.titleColor
        isUserInteractionEnabled = style.isUserInteractionEnabled
        titleLabel?.font = .regular16
        clipsToBounds = true
        
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
        layer.cornerRadius = 8
        
        addSubview(indicatorView)
        indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicatorView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if dumpable {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }, completion: nil)
        }
        super.touchesBegan(touches, with: event)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if dumpable {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
        super.touchesEnded(touches, with: event)
    }
}


