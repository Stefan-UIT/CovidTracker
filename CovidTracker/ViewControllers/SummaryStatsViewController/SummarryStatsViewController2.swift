//
//  SummarryStatsViewController2.swift
//  CovidTracker
//
//  Created by Trung Vo on 11/5/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit
import SnapKit
import SwiftUI

final class SummaryStatsViewController2: BaseViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        
        return tableView
    }()
    
    // MARK: - Properties
    private var viewModel: SummaryViewModel
    private let searchController = UISearchController(searchResultsController: nil)
    private var adapter: SummaryStatsAdapter!
    
    required init(viewModel: SummaryViewModel = SummaryViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("initWithCoder has not been implemented")
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        initViewModel()
        initAdapter()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}

// MARK: - Computed Variables
extension SummaryStatsViewController2 {
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
}

// MARK: - Private Helper Methods
extension SummaryStatsViewController2 {
    private func initAdapter() {
        adapter = SummaryStatsAdapter(delegate: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
    }
    
    private func initViewModel() {
        viewModel.delegate = self
    }
    
    private func setupUI() {
        title = Constants.Text.summary
        setupTableView()
        setupSearchViewController()
    }
    
    private func setupSearchViewController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.Text.search
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
    
    private func filterContentForSearchText(_ searchText: String) {
        viewModel.search(withText: searchText)
        tableView.reloadData()
    }
}

// MARK: - UISearchResultsUpdating
extension SummaryStatsViewController2: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

// MARK: - SummaryViewModelDelegate
extension SummaryStatsViewController2: SummaryViewModelDelegate {
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
extension SummaryStatsViewController2: SummaryStatsListProtocol {
    func didSelectShareAction(countryStats: CountryStats) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.openShareActivity(withText: countryStats.textToShare)
        }
    }
    
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
    
    func didSelectPreview(withViewController viewController: CountryDetailedStatsViewController) {
        coordinator?.push(viewController: viewController)
    }
    
    func retrieveNumberOfItems() -> Int {
        viewModel.numberOfCountryStats
    }
}

// swiftlint:disable all
#if DEBUG
struct SummaryStatsViewController2_Preview: PreviewProvider {
  static var previews: some View {
    Group {
        DebugPreviewViewController {
            let viewController = SummaryStatsViewController2()
            return viewController
        }
//        .previewLayout(.fixed(width: 300, height: 300))
//        .preferredColorScheme(.dark)
    }
  }
}
#endif
