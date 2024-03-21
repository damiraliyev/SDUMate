//
//  SessionsPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import Foundation

protocol ISessionsPresenter: AnyObject {
    
}

final class SessionsPresenter: ISessionsPresenter {
    
    weak var view: ISessionsView?
    
    init(view: ISessionsView) {
        self.view = view
    }
}

