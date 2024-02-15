//
//  DictionaryFoundation.swift
//  BePRO
//
//  Created by Sanzhar Dauylov on 24.01.2024.
//

import Foundation

public typealias JSON = [String: Any]

public extension Encodable {
    func makeDictionary(keyDecodingStrategy: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase) -> JSON {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = keyDecodingStrategy
        encoder.dateEncodingStrategy = .millisecondsSince1970
        guard let json = try? encoder.encode(self),
            let dict = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
            return [:]
        }
        return dict
    }
    
    func makeDictionaryWithoutNils(keyDecodingStrategy: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase) -> JSON {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = keyDecodingStrategy
        encoder.dateEncodingStrategy = .millisecondsSince1970
        guard let json = try? encoder.encode(self),
            let dict = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
            return [:]
        }
        var filteredDict: [String: Any] = [:]
        dict.forEach {
            if $0.value != nil || $0.value as? String != "" {
                filteredDict[$0.key] = $0.value
            }
        }
        return dict
    }
}
