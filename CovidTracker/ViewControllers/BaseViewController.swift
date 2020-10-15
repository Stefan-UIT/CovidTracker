//
//  BaseViewController.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var coordinator: MainCoordinator?
}

// MARK: - Storyboarded
extension BaseViewController: Storyboarded {}
