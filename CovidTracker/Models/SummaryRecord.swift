//
//  SummaryRecord.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

struct SummaryRecord {
    var newRecords: Record
    var totalRecords: Record
}

extension SummaryRecord: Decodable {
    private struct RawSummaryRecord: Decodable {
        var newConfirmed = 0
        var totalConfirmed = 0
        var newDeaths = 0
        var totalDeaths = 0
        var newRecovered = 0
        var totalRecovered = 0
        
        private enum CodingKeys: String, CodingKey {
            case newConfirmed = "NewConfirmed"
            case totalConfirmed = "TotalConfirmed"
            case newDeaths = "NewDeaths"
            case totalDeaths = "TotalDeaths"
            case newRecovered = "NewRecovered"
            case totalRecovered = "TotalRecovered"
        }
    }
    
    init(from decoder: Decoder) throws {
        let rawCountryRecord = try RawSummaryRecord(from: decoder)
        self.newRecords = Record(confirmed: rawCountryRecord.newConfirmed,
                                deaths: rawCountryRecord.newDeaths,
                                recovered: rawCountryRecord.newRecovered)
        self.totalRecords = Record(confirmed: rawCountryRecord.totalConfirmed,
                                  deaths: rawCountryRecord.totalDeaths,
                                  recovered: rawCountryRecord.totalRecovered)
    }
}
