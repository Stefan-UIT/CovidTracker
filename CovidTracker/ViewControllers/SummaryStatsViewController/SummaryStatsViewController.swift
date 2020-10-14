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
    
    var viewModel: SummaryViewModel!
    private let searchController = UISearchController(searchResultsController: nil)
    private var adapter: SummaryStatsAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initAdapter()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
 
    // MARK: - Private Methods
    private func initAdapter() {
        adapter = SummaryStatsAdapter(delegate: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
    }
    
    private func initViewModel() {
        viewModel.delegate = self
    }
    
    private func setupUI() {
        title = "Summary"
        setupTableView()
        setupSearchViewController()
    }
    
    private func setupSearchViewController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = false
    }
    
    private func setupTableView() {
        tableView.register(SummaryCountryStatsCell.uiNib(),
                           forCellReuseIdentifier: SummaryCountryStatsCell.identifier)
        tableView.register(SummaryGlobalStatsCell.uiNib(),
        forCellReuseIdentifier: SummaryGlobalStatsCell.identifier)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        viewModel.search(withText: searchText)
        tableView.reloadData()
    }
}

extension SummaryStatsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

extension SummaryStatsViewController: SummaryViewModelDelegate {
    var isSearching: Bool {
        searchController.isActive && !isSearchBarEmpty
    }
    
    func summaryViewModel(_ viewModel: SummaryViewModel, didFailWithError error: Error) {
        showAlert(message: error.localizedDescription)
    }
    
    func didLoadDataSuccessfully(in viewModel: SummaryViewModel) {
        tableView.reloadData()
    }
    
    func didFinishFetchingData(in viewModel: SummaryViewModel) {
        //
    }
}

// MARK: - SummaryStatsListProtocol
extension SummaryStatsViewController: SummaryStatsListProtocol {
    var summaryStats: SummaryStats {
        viewModel.summaryStats
    }
    
    var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }
    
    func countryStats(at indexPath: IndexPath) -> CountryStats {
         viewModel.countryStats(at: indexPath.row)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let countryStats = viewModel.countryStats(at: indexPath.row)
        coordinator?.redirectToCountryDetailVC(withCountry: countryStats)
    }
    
    func didSelectPreview(at countryStats: CountryStats) {
        coordinator?.redirectToCountryDetailVC(withCountry: countryStats)
    }
    
    func didSelectPreview(withViewController viewController: CountryDetailedStatsViewController) {
        coordinator?.push(viewController: viewController)
    }
    
    func wilDisplayItem(at indexPath: IndexPath) {
        
    }
    
    func retrieveNumberOfItems() -> Int {
        viewModel.numberOfCountryStats
    }
}

// MARK: - Computed Variables
extension SummaryStatsViewController {
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
}
