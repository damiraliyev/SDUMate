//
//  EntryModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import Foundation

final class EntryModuleFactory {
    
    func makeEntryView() -> IEntryView {
        return EntryViewController()
    }
}
