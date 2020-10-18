//
//  SummaryViewModel.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

// MARK: - MoviesViewModelDelegate
protocol SummaryViewModelDelegate: class {
    var isSearching: Bool { get }
    func didFinishFetchingData(in viewModel: SummaryViewModel)
    func didLoadDataSuccessfully(in viewModel: SummaryViewModel)
    func summaryViewModel(_ viewModel: SummaryViewModel, didFailWithError error: Error)
}

// MARK: - MoviesViewModelDelegate Optional Functions
extension SummaryViewModelDelegate {
    var isSearching: Bool { false }
    func didFinishFetchingData(in viewModel: SummaryViewModel) {}
}

// MARK: - SummaryViewModel
final class SummaryViewModel {
    private var provider: CovidNetworkable
    private (set) var summaryStats: SummaryStats
    private (set) var filteredCountryStats: [CountryStats]
    
    weak var delegate: SummaryViewModelDelegate?
    
    init(summaryStats: SummaryStats = Constants.InitalData.summaryStats,
         filteredCountryStats: [CountryStats] = [CountryStats](),
         provider: CovidNetworkable = CovidService()) {
        self.summaryStats = summaryStats
        self.filteredCountryStats = filteredCountryStats
        self.provider = provider
    }
    
    func search(withText searchText: String) {
        filteredCountryStats = summaryStats.countries.filter({
            $0.country.name.lowercased().contains(searchText.lowercased())
        })
    }
    
    func countryStats(at position: Int) -> CountryStats {
        isSearching ? filteredCountryStats[position] : summaryStats.countries[position]
    }
    
    func fetchSummaryStats() {
        provider.fetchSummaryStats { [weak self] (responseData, error) in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didFinishFetchingData(in: strongSelf)
            guard let data = responseData else {
                strongSelf.delegate?.summaryViewModel(strongSelf, didFailWithError: error!)
                return
            }
            strongSelf.summaryStats = data
            strongSelf.summaryStats.countries.sort {
                $0.record.confirmed > $1.record.confirmed
            }
            strongSelf.delegate?.didLoadDataSuccessfully(in: strongSelf)
        }
    }
}

// MARK: - Computed Variables
extension SummaryViewModel {
    private var isSearching: Bool {
        delegate?.isSearching ?? false
    }
    
    var numberOfCountryStats: Int {
        isSearching ? filteredCountryStats.count : summaryStats.countries.count
    }
}
