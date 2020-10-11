//
//  SummaryViewModel.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

// MARK: - MoviesViewModelDelegate
protocol SummaryViewModelDelegate: class {
    func didFinishFetchingData(in viewModel: SummaryViewModel)
    func didLoadDataSuccessfully(in viewModel: SummaryViewModel)
    func summaryViewModel(_ viewModel: SummaryViewModel, didFailWithError error: Error)
}

final class SummaryViewModel {
    private var provider: CovidNetworkable!
    private var summaryStats: SummaryStats!
    
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
    
    var numberOfItems: Int {
        summaryStats?.countries.count ?? 0
    }
    
    func countryStats(at position: Int) -> CountryStats {
        summaryStats.countries[position]
    }
    
    var globalStats: SummaryRecord {
        summaryStats.global
    }
}
