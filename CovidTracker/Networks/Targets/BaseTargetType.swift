
//
//  BaseTargetType.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Moya

extension TargetType {
    var baseURL: URL {
        return URL(string: AppGateways.covid19Api)!
    }
    
    var headers: [String: String]? {
        return [ Keys.contentType: Keys.applicationJson ]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
