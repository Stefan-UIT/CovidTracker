//
//  Record.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

struct Record {
    var confirmed = 0
    var deaths = 0
    var recovered = 0
    var active = 0
}

extension Record: Decodable {
    private enum CodingKeys: String, CodingKey {
        case confirmed = "Confirmed"
        case recovered = "Recovered"
        case deaths = "Deaths"
        case active = "Active"
    }
}
