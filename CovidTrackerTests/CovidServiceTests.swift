//
//  CovidServiceTests.swift
//  CovidTrackerTests
//
//  Created by Trung Vo on 10/16/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest

@testable import CovidTracker
@testable import Moya

class CovidServiceTests: XCTestCase {
    var sut: CovidService!
    let translationLayer = JsonTranslationLayer()
    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testFetchSummaryStatsSuccess() throws {
        let customEndpointClosure = { (target: CovidTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<CovidTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        sut = CovidService(networkTranslationLayer: JsonTranslationLayer(), provider: stubbingProvider)
        
        sut.fetchSummaryStats { (summaryStats, error) in
            XCTAssertNil(error)
            guard let stats = summaryStats else {
                XCTFail(TMessages.error)
                return
            }
            XCTAssertGreaterThan(stats.countries.count, 0)
        }
    }

    func testFetchSummaryStatsFailed() {
        let customEndpointClosure = { (target: CovidTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkError(TConstants.expectedError) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<CovidTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        sut = CovidService(networkTranslationLayer: JsonTranslationLayer(), provider: stubbingProvider)
        sut.fetchSummaryStats { (summaryStats, error) in
            XCTAssertNil(summaryStats)
            XCTAssertNotNil(error)
        }
    }
    
    func testFetchCountryDetailedStatsSuccess() {
        let customEndpointClosure = { (target: CovidTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<CovidTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        sut = CovidService(networkTranslationLayer: JsonTranslationLayer(), provider: stubbingProvider)
        
        sut.fetchCountryDetails(slug: "VN") { (response, error) in
            XCTAssertNil(error)
            guard let array = response else {
                    XCTFail(TMessages.error)
                    return
            }
            XCTAssertEqual(array.count, 1)
        }
    }
    
    func testFetchCountryDetailedStatsFailed() {
        let customEndpointClosure = { (target: CovidTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkError(TConstants.expectedError) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<CovidTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        sut = CovidService(networkTranslationLayer: JsonTranslationLayer(), provider: stubbingProvider)
        sut.fetchCountryDetails(slug: "VN") { (data, error) in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
        }
    }
}

