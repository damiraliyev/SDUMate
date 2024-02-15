//
//  UIImage+Extensions.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 18.09.2023.
//

import UIKit

extension UIImage {
    func compressIfNeeded(maxSizeInMB: Int = 1) -> Data? {
        let maxSize = maxSizeInMB * 1_000 * 1_000
        var compressionQuality: CGFloat = 1.0
        guard var imageData = self.jpegData(compressionQuality: compressionQuality) else { return nil }
        if imageData.count > maxSize {
            while imageData.count > maxSize && compressionQuality > 0 {
                compressionQuality -= 0.1
                if let compressedData = self.jpegData(compressionQuality: compressionQuality) {
                    imageData = compressedData
                }
            }
        }
        return imageData
    }
}
