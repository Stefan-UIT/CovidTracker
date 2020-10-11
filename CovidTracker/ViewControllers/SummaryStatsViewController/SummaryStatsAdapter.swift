//
//  SummaryStatsAdapter.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

protocol SummaryStatsListProtocol {
    func retrieveGlobalStats() -> SummaryRecord
    func countryStats(at indexPath: IndexPath) -> CountryStats
    func didSelectItem(at indexPath: IndexPath)
    func wilDisplayItem(at indexPath: IndexPath)
    func retrieveNumberOfItems() -> Int
}

// swiftlint:disable weak_delegate
class SummaryStatsAdapter: NSObject {
    let delegate: SummaryStatsListProtocol
    // MARK: - Constructor
    init(delegate: SummaryStatsListProtocol) {
        self.delegate = delegate
    }
}

// MARK: - UITableViewDataSource
extension SummaryStatsAdapter: UITableViewDataSource {
    private enum CellSection: Int, CaseIterable {
        case global = 0
        case country = 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        CellSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch CellSection(rawValue: section) {
        case .global:
            return 1
        default:
            return delegate.retrieveNumberOfItems()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate.wilDisplayItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = CellSection(rawValue: indexPath.section)
        switch section {
        case .global:
            return globalStatsCell(tableView, atIndexPath: indexPath)
        default:
            return countryStatsCell(tableView, atIndexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = CellSection(rawValue: indexPath.section)
        return section == CellSection.country ? 80 : 300
    }
    
    private func countryStatsCell(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> SummaryCountryStatsCell {
        let countryStats = delegate.countryStats(at: indexPath)
        let cell = tableView.dequeuCellOfType(SummaryCountryStatsCell.self)
        cell.configureCell(countryStats: countryStats)
        
        return cell
    }
    
    private func globalStatsCell(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> SummaryGlobalStatsCell {
        let globalStats = delegate.retrieveGlobalStats()
        let cell = tableView.dequeuCellOfType(SummaryGlobalStatsCell.self)
        cell.configureCell(globalStats: globalStats)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SummaryStatsAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate.didSelectItem(at: indexPath)
    }
}
