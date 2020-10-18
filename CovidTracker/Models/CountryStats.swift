//
//  CountryStats.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

struct CountryStats {
    var country: Country
    var record: Record
    var date: Date
    var coordinate: CLLocationCoordinate2D?
    
    var textToShare: String {
        "\(country.name)\n\(record.confirmed) - \(record.recovered) - \(record.deaths)"
    }
}

extension CountryStats: Decodable {
    private enum CodingKeys: String, CodingKey {
        case date = "Date"
    }
    
    init(from decoder: Decoder) throws {
        self.country = try Country(from: decoder)
        if let summary = try? SummaryRecord(from: decoder) {
            self.record = summary.totalRecords
        } else {
            self.record = try Record(from: decoder)
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
    }
}
