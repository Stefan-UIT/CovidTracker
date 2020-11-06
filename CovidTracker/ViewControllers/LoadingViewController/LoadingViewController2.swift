//
//  LoadingVIewController2.swift
//  CovidTracker
//
//  Created by Trung Vo on 11/4/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit
import SwiftUI

final class LoadingViewController2: BaseViewController {
    // MARK: - Private properties
    private var viewModel: SummaryViewModel
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.diagLogo)
        view.addSubview(imageView)
        
        return imageView
    }()
    
    required init(viewModel: SummaryViewModel = SummaryViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("initWithCoder has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.backgroundColor = UIColor.systemBackground
        setupConstraints()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.delegate = self
        imageView.startShimmeringAnimation(animationSpeed: 1.8)
        viewModel.fetchSummaryStats()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - SummaryViewModelDelegate
extension LoadingViewController2: SummaryViewModelDelegate {
    func didLoadDataSuccessfully(in viewModel: SummaryViewModel) {
        coordinator?.redirectToSummaryStatsVC(viewModel: viewModel)
        coordinator?.navigationController.viewControllers.removeFirst()
    }
    
    func summaryViewModel(_ viewModel: SummaryViewModel, didFailWithError error: Error) {
        showAlert(message: error.localizedDescription)
    }
}

// swiftlint:disable all
#if DEBUG
struct TestView_Preview: PreviewProvider {
  static var previews: some View {
    Group {
        DebugPreviewViewController {
            let viewController = LoadingViewController2()
            return viewController
        }
        .previewLayout(.fixed(width: 300, height: 300))
//        .preferredColorScheme(.dark)
    }
  }
}
#endif
