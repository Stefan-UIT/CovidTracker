//
//  Constants+Paths.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

struct AppGateways {
    static let covid19Api = "https://api.covid19api.com"
}

struct Paths {
    struct Covid {
        static let fetchSummaryStats = "/summary"
    }
}

struct Keys {
    static let contentType = "Content-Type"
    static let applicationJson = "application/json"
    static let main = "Main"
}
