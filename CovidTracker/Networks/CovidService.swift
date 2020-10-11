//
//  CovidService.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Moya

class CovidService {
    var provider = MoyaProvider<CovidTarget>()
    let translationLayer: Translatable
    
    init(networkTranslationLayer: Translatable = JsonTranslationLayer(),
         provider: MoyaProvider<CovidTarget> = MoyaProvider<CovidTarget>()) {
        self.translationLayer = networkTranslationLayer
        self.provider = provider
    }
}

// MARK: - Movies Network Services
extension CovidService: CovidNetworkable {
    func fetchSummaryData(completion: @escaping (SummaryRecords?, Error?) -> Void) {
        provider.request(CovidTarget.fetchSummaryData, completion: { (response) in
            switch response {
            case .failure(let error):
                completion(nil, error)
            case .success(let response):
                do {
                    let decodedData = try self.translationLayer.decode(SummaryRecords.self, fromData: response.data)
                    completion(decodedData, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        })
    }
}
