//
//  SummaryStatsAdapter.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

// MARK: - SummaryStatsListProtocol
protocol SummaryStatsListProtocol {
    var isSearching: Bool { get }
    var summaryStats: SummaryStats { get }
    
    func countryStats(at indexPath: IndexPath) -> CountryStats
    func didSelectItem(at indexPath: IndexPath)
    func retrieveNumberOfItems() -> Int
    func didSelectPreview(withViewController viewController: CountryDetailedStatsViewController)
}

// swiftlint:disable weak_delegate
class SummaryStatsAdapter: NSObject {
    let delegate: SummaryStatsListProtocol
    // MARK: - Constructor
    init(delegate: SummaryStatsListProtocol) {
        self.delegate = delegate
    }
}

// MARK: - Computed Variable
extension SummaryStatsAdapter {
    var isSearching: Bool {
        delegate.isSearching
    }
}

// MARK: - UITableViewDataSource
extension SummaryStatsAdapter: UITableViewDataSource {
    private enum CellSection: Int, CaseIterable {
        case global = 0
        case country = 1
        
        var rowHeight: CGFloat {
            switch self {
            case .global:
                return 230
            default:
                return 80
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        isSearching ? 1 : CellSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? delegate.retrieveNumberOfItems() : numberOfRow(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        isSearching ? countryStatsCell(tableView, atIndexPath: indexPath) : cellForRow(inTableView: tableView, atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        isSearching ? CellSection.country.rowHeight : rowHeight(inSection: indexPath.section)
    }
}

// MARK: - UITableViewDelegate
extension SummaryStatsAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate.didSelectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let countryStats = delegate.countryStats(at: indexPath)
        let previewController = CountryDetailedStatsViewController.instantiate()
        previewController.countryStats = countryStats
        return UIContextMenuConfiguration(
        identifier: countryStats.country.slug as NSString,
        previewProvider: { previewController }) { _ in
            let shareAction = UIAction(
                title: Constants.Text.share,
              image: UIImage.shareIcon) { _ in
                // TODO: implement share
            }
            let copyAction = UIAction(
              title: Constants.Text.copy,
              image: UIImage.copyIcon) { _ in
                // TODO: implement Copy
            }
            return UIMenu(title: "", children: [shareAction, copyAction])
        }
    }
    
    func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        guard let destinationViewController = animator.previewViewController as? CountryDetailedStatsViewController  else { return }
        animator.addAnimations {
            self.delegate.didSelectPreview(withViewController: destinationViewController)
        }
    }
}

// MARK: - Private Helpers
extension SummaryStatsAdapter {
    private func rowHeight(inSection section: Int) -> CGFloat {
        CellSection(rawValue: section)?.rowHeight ?? 0
    }
    
    private func numberOfRow(inSection section: Int) -> Int {
        switch CellSection(rawValue: section) {
        case .global:
            return 1
        default:
            return delegate.retrieveNumberOfItems()
        }
    }
    
    private func cellForRow(inTableView tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cellSection = CellSection(rawValue: indexPath.section)
        switch cellSection {
        case .global:
            return globalStatsCell(tableView, atIndexPath: indexPath)
        default:
            return countryStatsCell(tableView, atIndexPath: indexPath)
        }
    }
    
    private func countryStatsCell(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> SummaryCountryStatsCell {
        let countryStats = delegate.countryStats(at: indexPath)
        let cell = tableView.dequeuCellOfType(SummaryCountryStatsCell.self)
        cell.configureCell(countryStats: countryStats, date: delegate.summaryStats.date)
        
        return cell
    }
    
    private func globalStatsCell(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> SummaryGlobalStatsCell {
        let globalStats = delegate.summaryStats.global
        let cell = tableView.dequeuCellOfType(SummaryGlobalStatsCell.self)
        cell.configureCell(globalStats: globalStats, date: delegate.summaryStats.date)
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        
        return cell
    }
}
