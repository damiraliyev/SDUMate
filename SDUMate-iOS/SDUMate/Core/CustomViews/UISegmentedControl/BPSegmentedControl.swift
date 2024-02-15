//
//  BPSegmentedControl.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 25.08.2023.
//
import Foundation
import UIKit

public class BPSegmentedControl: UISegmentedControl {
    private struct Constants {
        static let animationKey = "SelectionBounds"
    }

    private let segmentInset: CGFloat
    private let segmentImage: UIImage
    private var cornerRadius: CGFloat
    public var items: [String] = [] {
        didSet {
            removeAllSegments()
            items.enumerated().forEach { (id, item) in
                insertSegment(withTitle: item, at: id, animated: false)
            }
        }
    }

    public init(
        color: UIColor,
        selectedColor: UIColor,
        titleColor: UIColor,
        selectedTitleColor: UIColor,
        segmentInset: CGFloat = 3.0,
        cornerRadius: CGFloat = 16,
        items: [String] = []
    )
    {
        self.segmentInset = segmentInset
        self.cornerRadius = cornerRadius
        self.segmentImage = UIImage(color: selectedColor) ?? UIImage()
        super.init(frame: .zero)
        tintColor = color
        selectedSegmentTintColor = selectedColor
        setTitleTextAttributes([.foregroundColor: titleColor], for: .normal)
        setTitleTextAttributes([.foregroundColor: selectedTitleColor], for: .selected)
        
        items.enumerated().forEach { (id, item) in
            insertSegment(withTitle: item, at: id, animated: false)
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews(){
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height/2
        let foregroundIndex = numberOfSegments
        
        if subviews.indices.contains(foregroundIndex),
           let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            foregroundImageView.image = segmentImage    //substitute with our own colored image
            foregroundImageView.layer.removeAnimation(forKey: Constants.animationKey)    // this removes the weird scaling animation!
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.layer.cornerRadius = foregroundImageView.bounds.height/2
        }
    }
}

fileprivate extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

