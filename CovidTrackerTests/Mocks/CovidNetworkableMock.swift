//
//  CovidNetworkableMock.swift
//  CovidTrackerTests
//
//  Created by Trung Vo on 10/15/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation
@testable import CovidTracker
@testable import Moya

class CovidNetworkableMock: CovidNetworkable {
    var provider = MoyaProvider<CovidTarget>()
    var isFetchCountryDetailedStatsSuccess: Bool? = .none
    var isFetchSummaryStatsSuccess: Bool? = .none
    var isForceNetwokFailed = false
    
    func fetchSummaryStats(completion: @escaping (SummaryStats?, Error?) -> Void) {
        if isForceNetwokFailed {
            completion(nil, TConstants.expectedError)
        } else {
            completion(TConstants.Data.summaryStats, nil)
        }
    }
    
    func fetchCountryDetails(slug: String, completion: @escaping ([CountryStats]?, Error?) -> Void) {
        if isForceNetwokFailed {
            completion(nil, TConstants.expectedError)
        } else {
            completion(TConstants.Data.summaryStats.countries, nil)
        }
    }
}
