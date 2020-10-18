//
//  SceneDelegate.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var coordinator: MainCoordinator?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navController = setupCoordinator()
        setupWindow(navController: navController, windowScene: windowScene)
        coordinator?.start()
    }
}

// MARK: - Private helpers
extension SceneDelegate {
    private func setupCoordinator() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.tintColor = UIColor.covidPink
        coordinator = MainCoordinator(navigationController: navController)
        return navController
    }
    
    private func setupWindow(navController: UINavigationController, windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
