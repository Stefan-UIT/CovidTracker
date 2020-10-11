//
//  CovidNetworkable.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Moya

protocol CovidNetworkable {
    var provider: MoyaProvider<CovidTarget> { get }

    func fetchSummaryData(completion: @escaping (SummaryRecords?, Error?) -> Void)
}
