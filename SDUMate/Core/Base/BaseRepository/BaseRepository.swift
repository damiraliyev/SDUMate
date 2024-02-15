//
//  BaseRepository.swift
//  BePRO
//
//  Created by Yessenali Zhanaidar on 11.07.2023.
//

import Moya

// MARK: TO DO BaseRepository, need to consult

open class BaseRepository<Target: TargetType> {
    
    public let provider: MoyaProvider<Target>
    
    init(provider: MoyaProvider<Target>) {
        self.provider = provider
    }
    
    open func makeRequest(api: Target, completion: @escaping Moya.Completion) -> Void {
        provider.request(api, completion: completion)
    }
}
