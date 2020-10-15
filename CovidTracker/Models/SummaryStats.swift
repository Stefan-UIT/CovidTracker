//
//  SummaryStats.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

struct SummaryStats {
    var global: SummaryRecord
    var countries: [CountryStats]
    var date: Date
}

extension SummaryStats: Decodable {
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
        case date = "Date"
    }
}
