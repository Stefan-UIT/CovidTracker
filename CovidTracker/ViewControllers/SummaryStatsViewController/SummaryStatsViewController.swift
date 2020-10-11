//
//  SummaryViewController.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

final class SummaryStatsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: SummaryViewModel!
    private var adapter: SummaryStatsAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupUI()
    }
    
    // MARK: - Private Methods
    private func initAdapter() {
        adapter = SummaryStatsAdapter(delegate: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
    }
    
    private func initViewModel() {
        viewModel = SummaryViewModel()
        viewModel.delegate = self
        viewModel.fetchSummaryStats()
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(SummaryCountryStatsCell.uiNib(),
                           forCellReuseIdentifier: SummaryCountryStatsCell.identifier)
        tableView.register(SummaryGlobalStatsCell.uiNib(),
        forCellReuseIdentifier: SummaryGlobalStatsCell.identifier)
    }
}

extension SummaryStatsViewController: SummaryViewModelDelegate {
    func summaryViewModel(_ viewModel: SummaryViewModel, didFailWithError error: Error) {
        print(error)
    }
    
    func didLoadDataSuccessfully(in viewModel: SummaryViewModel) {
        initAdapter()
        tableView.reloadData()
    }
    
    func didFinishFetchingData(in viewModel: SummaryViewModel) {
        //
    }
}

// MARK: - SummaryStatsListProtocol
extension SummaryStatsViewController: SummaryStatsListProtocol {
    func retrieveGlobalStats() -> SummaryRecord {
        viewModel.globalStats
    }
    func countryStats(at indexPath: IndexPath) -> CountryStats {
        viewModel.countryStats(at: indexPath.row)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }
    
    func wilDisplayItem(at indexPath: IndexPath) {
        
    }
    
    func retrieveNumberOfItems() -> Int {
        viewModel.numberOfItems
    }
}
