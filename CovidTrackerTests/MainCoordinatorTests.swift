//
//  MainCoordinatorTests.swift
//  CovidTrackerTests
//
//  Created by Trung Vo on 10/16/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import CovidTracker

class MainCoordinatorTests: XCTestCase {
    var sut: MainCoordinator!
    var navController: UINavigationController!
    var summaryVC: SummaryStatsViewController!

    override func setUpWithError() throws {
        super.setUp()
        navController = UINavigationController()
        summaryVC = SummaryStatsViewController()
        sut = MainCoordinator(navigationController: navController)
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testStartIsWorked() throws {
        XCTAssertEqual(sut.navigationController.viewControllers.count, 0)
        sut.start(withViewController: summaryVC)
        let result = try XCTUnwrap(sut.navigationController.viewControllers.first)
        XCTAssertEqual(result, summaryVC)
    }
    
    func testRedirectToCountryDetailedStatsVCSuccess() throws {
        sut.redirectToCountryDetailVC(withCountry: TConstants.Data.countryStats1)
        let result = try XCTUnwrap(sut.navigationController.viewControllers[0] as? CountryDetailedStatsViewController)
        XCTAssertEqual(result.countryStats.country.slug, TConstants.Data.country1.slug)
    }
}
