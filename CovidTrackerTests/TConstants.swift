//
//  TConstants.swift
//  CovidTrackerTests
//
//  Created by Trung Vo on 10/15/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

@testable import CovidTracker

enum TConstants {
    enum Data {
        static let summaryStats = SummaryStats(global: summaryRecord, countries: [countryStats1, countryStats2], date: Date())
        static let summaryRecord = SummaryRecord(newRecords: record1, totalRecords: record2)
        static let record1 = Record(confirmed: 1, deaths: 1, recovered: 1, active: 1)
        static let record2 = Record(confirmed: 2, deaths: 2, recovered: 2, active: 2)
        static let countryStats1 = CountryStats(country: country1, record: record1, date: Date())
        static let countryStats2 = CountryStats(country: country2, record: record2, date: Date())
        
        static let country1 = Country(name: "Viet Nam", slug: "VN")
        static let country2 = Country(name: "China", slug: "Chinaaaa")
    }
    static let expectedError = NSError(domain: "domain", code: 404, userInfo: nil)
}

enum TMessages {
    static let delegateWasNotCalled = "Delegate was not called"
    static let delegateGetCalling = "Delegate get calling"
    static let timeOutWithError = "Time out errored: %@"
    static let delegateWasNotSetUpCorrect = "Delegate was not setup correctly"
    static let error = "Error"
    static let invalidPath = "Invalid path"
}
