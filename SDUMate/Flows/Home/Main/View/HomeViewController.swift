//
//  HomeViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 17.03.2024.
//

import UIKit

protocol IHomeView: Presentable {
    var presenter: IHomePresenter? { get set }
}

final class HomewViewController: BaseViewController {
    var presenter: IHomePresenter?
}

extension HomewViewController: IHomeView {
    
}
