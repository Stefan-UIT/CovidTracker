//
//  CovidTarget.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Moya

enum CovidTarget {
    case fetchSummaryStats
}

extension CovidTarget: TargetType {
    var path: String {
        switch self {
        case .fetchSummaryStats:
            return Paths.Covid.fetchSummaryStats
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any] {
        [String: Any]()
    }
    
    var task: Task {
        switch self {
        case .fetchSummaryStats:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    // For unit test
    var sampleData: Data {
        Data()
    }
}
