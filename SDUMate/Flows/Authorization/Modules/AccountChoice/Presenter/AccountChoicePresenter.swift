//
//  AccountChoicePresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import UIKit

protocol IAccountChoicePresenter: AnyObject {
    func studentTapped()
    func alumniTapped()
}

final class AccountChoicePresenter: IAccountChoicePresenter {
    
    weak var view: IAccountChoiceView?
    private weak var coordinator: IAuthCoordinator?
    
    init(view: IAccountChoiceView? = nil, coordinator: IAuthCoordinator? = nil) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func studentTapped() {
        
    }
    
    func alumniTapped() {
        
    }
}
