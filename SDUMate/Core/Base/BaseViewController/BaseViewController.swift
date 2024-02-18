//
//  BaseViewController.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 05.07.2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSkeleton()
        didChangeLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.setObserver(self, selector: #selector(didChangeLanguage), name: .languageDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("✅✅✅✅ \(self) is deinited")
    }
    
    func setupSkeleton() { }
    
    @objc func didChangeLanguage() { }
}

extension BaseViewController: CoordinatorNavigationControllerDelegate { }
