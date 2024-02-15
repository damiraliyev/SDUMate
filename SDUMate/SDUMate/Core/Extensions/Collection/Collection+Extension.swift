//
//  Collection+Extension.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 06.07.2023.
//

import Foundation

extension Collection {
    subscript(safe i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : nil
    }
}

extension Array {
    var middle: Element? {
        guard count != 0 else { return nil }
        
        let middleIndex = count / 2
        return self[middleIndex]
    }
}
