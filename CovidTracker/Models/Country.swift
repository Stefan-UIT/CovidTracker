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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        if let slugValue = try? container.decode(String.self, forKey: .slug) {
            self.slug = slugValue
        }
    }
}
