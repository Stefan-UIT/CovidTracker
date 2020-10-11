//
//  MainCoordinator.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(withViewController viewController: BaseViewController = SummaryViewController.instantiate()) {
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
}
