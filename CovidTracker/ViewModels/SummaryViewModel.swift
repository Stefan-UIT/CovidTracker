//
//  SummaryViewModel.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

final class SummaryViewModel {
    private var provider: CovidNetworkable!
    private var summaryRecords: SummaryRecords!
    
    init(provider: CovidNetworkable = CovidService()) {
        self.provider = provider
    }
    
    func fetchSummaryData() {
        provider.fetchSummaryData { [weak self] (responseData, error) in
            guard let strongSelf = self else { return }
            guard let data = responseData else {
                print(error!)
                // did Failed with error
                return
            }
            strongSelf.summaryRecords = data
        }
    }
}
