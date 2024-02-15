//
//  DumpableButton.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 09.10.2023.
//

import UIKit

final class DumpableButton: BPPaddingButton {
    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .medium
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var loading: Bool = false {
        didSet {
            loading ? indicatorView.startAnimating() : indicatorView.stopAnimating()
            isUserInteractionEnabled = !loading
        }
    }
    
    override init(inset: CGFloat = .zero) {
        super.init(inset: inset)
        addSubview(indicatorView)
        indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicatorView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var dumpable: Bool = true

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if dumpable {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }, completion: nil)
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if dumpable {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.transform = .identity
            }, completion: nil)
        }
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if dumpable {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.transform = .identity
            }, completion: nil)
        }
        super.touchesCancelled(touches, with: event)
    }
}
