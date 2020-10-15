//
//  Constants+Paths.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

enum AppGateways {
    static let covid19Api = "https://api.covid19api.com"
}

enum Paths {
    struct Covid {
        static let fetchSummaryStats = "/summary"
        static let fetchCountryDetails = "/country/%@"
    }
}

enum Keys {
    static let contentType = "Content-Type"
    static let applicationJson = "application/json"
    static let main = "Main"
}

enum Constants {
    enum InitalData {
        static let summaryStats = SummaryStats(global: summaryRecord, countries: [CountryStats](), date: Date())
        static let summaryRecord = SummaryRecord(newRecords: Record(), totalRecords: Record())
    }
    
    enum Text {
        static let share = "Share"
        static let copy = "Copy"
        static let search = "Search"
        static let summary = "Summary"
    }
}
