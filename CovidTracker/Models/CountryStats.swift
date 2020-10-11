//
//  CountryStats.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

struct CountryStats {
    var country: Country
    var summary: SummaryRecord
    var date: Date
}

extension CountryStats: Decodable {
    private enum CodingKeys: String, CodingKey {
        case country, summary
        case date = "Date"
    }
    
    init(from decoder: Decoder) throws {
        self.country = try Country(from: decoder)
        self.summary = try SummaryRecord(from: decoder)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
    }
}
