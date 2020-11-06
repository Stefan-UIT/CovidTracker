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

//    func start(withViewController viewController: BaseViewController = LoadingViewController.instantiate()) {
//        viewController.coordinator = self
//        navigationController.pushViewController(viewController, animated: false)
//    }
    
    func start(withViewController viewController: BaseViewController = LoadingViewController2()) {
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func redirectToSummaryStatsVC(viewModel: SummaryViewModel) {
//        let countryDetailedStatsVC = SummaryStatsViewController.instantiate()
        let countryDetailedStatsVC = SummaryStatsViewController2(viewModel: viewModel)
        countryDetailedStatsVC.coordinator = self
        navigationController.pushViewController(countryDetailedStatsVC, animated: true)
    }
    
    func redirectToCountryDetailVC(withCountry countryStats: CountryStats) {
        let countryDetailedStatsVC = CountryDetailedStatsViewController.instantiate()
        countryDetailedStatsVC.countryStats = countryStats
        countryDetailedStatsVC.coordinator = self
        navigationController.pushViewController(countryDetailedStatsVC, animated: true)
    }
    
    func push(viewController: BaseViewController) {
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
