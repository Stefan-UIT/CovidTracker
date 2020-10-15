//
//  SummaryViewModelTests.swift
//  CovidTrackerTests
//
//  Created by Trung Vo on 10/15/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import CovidTracker

class SummaryViewModelTests: XCTestCase {
    var sut: SummaryViewModel!
    var networkMock: CovidNetworkableMock!
    var delegateMock: SummaryViewModelDelegateMock!
    
    override func setUpWithError() throws {
        super.setUp()
        networkMock = CovidNetworkableMock()
        delegateMock = SummaryViewModelDelegateMock()
        sut = SummaryViewModel(summaryStats: TConstants.Data.summaryStats,
                               provider: networkMock)
        sut.delegate = delegateMock
        
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testFetchSummaryStatsSuccess() {
        sut.fetchSummaryStats()

        XCTAssertGreaterThan(sut.numberOfCountryStats, 0)
        XCTAssertEqual(sut.countryStats(at: 1).country.slug, TConstants.Data.countryStats1.country.slug)
        XCTAssertEqual(sut.countryStats(at: 0).country.slug, TConstants.Data.countryStats2.country.slug)

    }
    
    func testGetNumberOfItems() {
        sut.fetchSummaryStats()
        XCTAssertEqual(sut.numberOfCountryStats, 2)
    }
    
    func testSearchSuccess() throws {
        sut.search(withText: "viet")
        let result = try XCTUnwrap(sut.filteredCountryStats.first)
        XCTAssertEqual(result.country.slug, TConstants.Data.country1.slug)
    }
    
    func testSearchEmptySuccess() {
        sut.search(withText: "Thisisneverhavearesult")
        XCTAssertEqual(sut.filteredCountryStats.count, 0)
    }
    
    func testGetCountryStatsWhenNoSearchSuccess() {
        sut = SummaryViewModel(summaryStats: TConstants.Data.summaryStats,
                               filteredCountryStats: [TConstants.Data.countryStats2])
        delegateMock.isSearchingMock = false
        sut.delegate = delegateMock
        let stats = sut.countryStats(at: 0)
        XCTAssertEqual(stats.country.slug, TConstants.Data.countryStats1.country.slug)
    }
    
    func testGetCountryStatsWhenSearchingSuccess() {
        sut = SummaryViewModel(summaryStats: TConstants.Data.summaryStats,
                               filteredCountryStats: [TConstants.Data.countryStats2])
        delegateMock.isSearchingMock = true
        sut.delegate = delegateMock
        let stats = sut.countryStats(at: 0)
        XCTAssertEqual(stats.country.slug, TConstants.Data.countryStats2.country.slug)
    }
    
    // Delegates
    func testDidFinishFetchingDataDelegateIsCalled() {
        sut.fetchSummaryStats()
        XCTAssertTrue(delegateMock.isDidFinishFetchingData)
    }
    
    func testDidLoadDataSuccessfullyDelegateIsCalled() {
        sut.fetchSummaryStats()
        XCTAssertTrue(delegateMock.isDidLoadDataSuccessfully)
    }
    
    func testDidFailWithErrorDelegateIsCalled() throws {
        networkMock.isForceNetwokFailed = true
        sut = SummaryViewModel(provider: networkMock)
        sut.delegate = delegateMock
        sut.fetchSummaryStats()
        
        let error = try XCTUnwrap(delegateMock.error)
        XCTAssertEqual(error as NSError, TConstants.expectedError)
    }
}
