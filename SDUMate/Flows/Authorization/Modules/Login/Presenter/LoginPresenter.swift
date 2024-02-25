//
//  LoginPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 25.02.2024.
//

import Foundation

protocol ILoginPresenter: AnyObject {
    
}

final class LoginPresenter: ILoginPresenter {
    
    weak var view: ILoginView?
    
    init(view: ILoginView) {
        self.view = view
    }
}
