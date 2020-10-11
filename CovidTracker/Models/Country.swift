//
//  Country.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

struct Country {
    var name: String = ""
    var slug: String = ""
}

extension Country: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name = "Country"
        case slug = "Slug"
    }
}
