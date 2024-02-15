//
//  EntryViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 15.02.2024.
//

import UIKit

protocol IEntryView: Presentable {
    var presenter: IEntryPresenter? { get set }
}

final class EntryViewController: BaseViewController, IEntryView {
    var presenter: IEntryPresenter?
    
    override func viewDidLoad() {
        view.backgroundColor = .cyan
    }
}
