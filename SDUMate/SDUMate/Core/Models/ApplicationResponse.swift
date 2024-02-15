//
//  ApplicationResponse.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 04.01.2024.
//

import Foundation

struct ApplicationResponse: Decodable {
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }
}
