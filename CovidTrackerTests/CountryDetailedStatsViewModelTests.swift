//
//  CountryDetailedStatsViewModelTests.swift
//  CovidTrackerTests
//
//  Created by Trung Vo on 10/16/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import CovidTracker

class CountryDetailedStatsViewModelTests: XCTestCase {
    var sut: CountryDetailedStatsViewModel!
    var networkMock: CovidNetworkableMock!
    var delegateMock: CountryDetailedStatsViewModelDelegateMock!
    
    override func setUpWithError() throws {
        super.setUp()
        networkMock = CovidNetworkableMock()
        delegateMock = CountryDetailedStatsViewModelDelegateMock()
        sut = CountryDetailedStatsViewModel(provider: networkMock)
        sut.delegate = delegateMock
        
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testFetchSummaryStatsSuccess() {
        sut.fetchCountryDetails()
        XCTAssertEqual(sut.statsArray.count, 2)
    }
    
    // Delegates
    func testDidFinishFetchingDataDelegateIsCalled() {
        sut.fetchCountryDetails()
        XCTAssertTrue(delegateMock.isDidFinishFetchingData)
    }
    
    func testWillLoadDelegateIsCalled() {
        sut.fetchCountryDetails()
        XCTAssertTrue(delegateMock.isWillLoadSuccessfully)
    }
    
    func testDidLoadDataSuccessfullyDelegateIsCalled() {
        sut.fetchCountryDetails()
        XCTAssertTrue(delegateMock.isDidLoadDataSuccessfully)
    }
    
    func testDidFailWithErrorDelegateIsCalled() throws {
        networkMock.isForceNetwokFailed = true
        sut = CountryDetailedStatsViewModel(provider: networkMock)
        sut.delegate = delegateMock
        sut.fetchCountryDetails()
        
        let error = try XCTUnwrap(delegateMock.error)
        XCTAssertEqual(error as NSError, TConstants.expectedError)
    }
}
