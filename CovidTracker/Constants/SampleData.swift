//
//  SampleData.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/15/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

enum SampleData {
    case summaryStats
    case countryDetailedStats
    
    var fileName: String {
        switch self {
        case .summaryStats:
            return "SummaryStats"
        case .countryDetailedStats:
            return "CountryDetailedStats"
        }
    }
    
    var data: Data {
        getData(filename: self.fileName)
    }
    
    func getData(filename fileName: String) -> Data {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                return Data()
            }
        }
        return Data()
    }
}
