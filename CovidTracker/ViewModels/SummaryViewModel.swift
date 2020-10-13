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

final class SummaryViewModel {
    private var provider: CovidNetworkable!
    private (set) var summaryStats: SummaryStats!
    var filteredCountryStats = [CountryStats]()
    
    weak var delegate: SummaryViewModelDelegate?
    
    init(provider: CovidNetworkable = CovidService()) {
        self.provider = provider
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
            strongSelf.delegate?.didLoadDataSuccessfully(in: strongSelf)
        }
    }
    
    private var isSearching: Bool {
        delegate?.isSearching ?? false
    }
    
    func search(withText searchText: String) {
        filteredCountryStats = summaryStats.countries.filter({$0.country.name.lowercased().contains(searchText.lowercased())})
    }
    
    var numberOfCountryStats: Int {
        isSearching ? filteredCountryStats.count : summaryStats.countries.count
    }
    
    func countryStats(at position: Int) -> CountryStats {
        isSearching ? filteredCountryStats[position] : summaryStats.countries[position]
        
    }
}
