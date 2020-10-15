//
//  CountryDetailedStatsViewModel.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/15/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

// MARK: - CountryDetailedStatsViewModelDelegate
protocol CountryDetailedStatsViewModelDelegate: class {
    func willLoadData(in viewModel: CountryDetailedStatsViewModel)
    func didFinishFetchingData(in viewModel: CountryDetailedStatsViewModel)
    func didLoadDataSuccessfully(in viewModel: CountryDetailedStatsViewModel)
    func viewModel(_ viewModel: CountryDetailedStatsViewModel, didFailWithError error: Error)
}

// MARK: - CountryDetailedStatsViewModel
class CountryDetailedStatsViewModel {
    private var provider: CovidNetworkable
    private (set) var statsArray: [CountryStats]
    var countrySlug: String
    weak var delegate: CountryDetailedStatsViewModelDelegate?
    
    init(slug: String,
         statsArray: [CountryStats] = [CountryStats](),
         provider: CovidNetworkable = CovidService()) {
        self.provider = provider
        self.countrySlug = slug
        self.statsArray = statsArray
    }
    
    func fetchCountryDetails() {
        delegate?.willLoadData(in: self)
        provider.fetchCountryDetails(slug: countrySlug) { [weak self] (responseData, error) in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didFinishFetchingData(in: strongSelf)
            guard let data = responseData else {
                strongSelf.delegate?.viewModel(strongSelf, didFailWithError: error!)
                return
            }
            strongSelf.statsArray = data.reversed()
            strongSelf.delegate?.didLoadDataSuccessfully(in: strongSelf)
        }
    }
}
