//
//  CountryDetailedStatsViewModelMock.swift
//  CovidTrackerTests
//
//  Created by Trung Vo on 10/16/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest

@testable import CovidTracker

class CountryDetailedStatsViewModelDelegateMock {
    var asyncExpectation: XCTestExpectation?
    var isDidFinishFetchingData = false
    var isDidLoadDataSuccessfully = false
    var isWillLoadSuccessfully = false
    var error: Error?
}

extension CountryDetailedStatsViewModelDelegateMock: CountryDetailedStatsViewModelDelegate {
    func willLoadData(in viewModel: CountryDetailedStatsViewModel) {
        isWillLoadSuccessfully = true
    }
    
    func didFinishFetchingData(in viewModel: CountryDetailedStatsViewModel) {
        isDidFinishFetchingData = true
    }
    
    func viewModel(_ viewModel: CountryDetailedStatsViewModel, didFailWithError error: Error) {
        self.error = error
    }
    func didLoadDataSuccessfully(in viewModel: CountryDetailedStatsViewModel) {
        isDidLoadDataSuccessfully = true
    }
}
