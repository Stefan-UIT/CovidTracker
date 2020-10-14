//
//  LoadingViewController.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/14/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class LoadingViewController: BaseViewController {
    private let viewModel = SummaryViewModel()

    @IBOutlet weak var loadingImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.delegate = self
        loadingImageView.startShimmeringAnimation(animationSpeed: 1.8)
        viewModel.fetchSummaryStats()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension LoadingViewController: SummaryViewModelDelegate {
    func didLoadDataSuccessfully(in viewModel: SummaryViewModel) {
        coordinator?.redirectToSummaryStatsVC(viewModel: viewModel)
        coordinator?.navigationController.viewControllers.removeFirst()
    }
    
    func summaryViewModel(_ viewModel: SummaryViewModel, didFailWithError error: Error) {
        showAlert(message: error.localizedDescription)
    }
}
