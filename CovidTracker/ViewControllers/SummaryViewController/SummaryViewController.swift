//
//  SummaryViewController.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

final class SummaryViewController: BaseViewController {
    private var viewModel: SummaryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    private func initViewModel() {
        viewModel = SummaryViewModel()
        viewModel.fetchSummaryData()
    }
}
