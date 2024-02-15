//
//  FeedNavigationController.swift
//  BePRO
//
//  Created by Nurkanat Klimov on 29.12.2023.
//

import UIKit
//import PanModal

final class FeedNavigationController: CoordinatorNavigationController {

    #warning("Need to implement in different way.")
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        panModalSetNeedsLayoutUpdate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.panModalTransition(to: .longForm)
        }
    }
}
