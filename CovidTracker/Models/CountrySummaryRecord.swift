//
//  CountrySummaryRecord.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

struct CountrySummaryRecord {
    var country: Country
    var summaryRecord: SummaryRecord
    var date: Date
}

extension CountrySummaryRecord: Decodable {
    private enum CodingKeys: String, CodingKey {
        case country, summaryRecord
        case date = "Date"
    }
    
    init(from decoder: Decoder) throws {
        self.country = try Country(from: decoder)
        self.summaryRecord = try SummaryRecord(from: decoder)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
    }
}
