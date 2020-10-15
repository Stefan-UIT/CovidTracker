//
//  Constants.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/15/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

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
