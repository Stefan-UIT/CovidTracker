//
//  SummaryRecords.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

struct SummaryRecords {
    var global: SummaryRecord
    var countries: [CountrySummaryRecord]
}

extension SummaryRecords: Decodable {
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
    }
}
