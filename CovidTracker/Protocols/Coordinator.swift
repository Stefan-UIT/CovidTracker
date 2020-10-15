//
//  Coordinator.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start(withViewController viewController: BaseViewController)
}
