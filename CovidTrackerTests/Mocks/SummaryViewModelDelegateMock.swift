//
//  SummaryViewModelDelegateMock.swift
//  CovidTrackerTests
//
//  Created by Trung Vo on 10/15/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import CovidTracker

class SummaryViewModelDelegateMock {
    var asyncExpectation: XCTestExpectation?
    var isDidFinishFetchingData = false
    var isDidLoadDataSuccessfully = false
    var error: Error?
    var isSearchingMock = false
}

extension SummaryViewModelDelegateMock: SummaryViewModelDelegate {
    var isSearching: Bool {
       isSearchingMock
    }
    
    func didFinishFetchingData(in viewModel: SummaryViewModel) {
        isDidFinishFetchingData = true
    }
    
    func didLoadDataSuccessfully(in viewModel: SummaryViewModel) {
        isDidLoadDataSuccessfully = true
    }
    
    func summaryViewModel(_ viewModel: SummaryViewModel, didFailWithError error: Error) {
        self.error = error
    }
}
