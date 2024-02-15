//
//  UIImageView+Extentions.swift
//  BePRO
//
//  Created by Yeldos Marat on 29.12.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageFrom(url: String, cacheKey: String? = nil, placeholder: UIImage? = nil, header: [String: String] = [:]) {
        guard let imageURL = URL(string: url) else {
            self.image = UIImage(named: url)
            return
        }
        var key = url
        if let cacheKey = cacheKey {
            key = cacheKey
        }
        let modifier = AnyModifier { request in
            var r = request
            header.forEach {
                r.setValue($0.value, forHTTPHeaderField: $0.key)
            }
            return r
        }
        let resource = KF.ImageResource(downloadURL: imageURL, cacheKey: key)
        self.kf.setImage(with: resource,
                         placeholder: placeholder,
                         options: [.transition(.fade(0.2)), .requestModifier(modifier)])
    }
}
