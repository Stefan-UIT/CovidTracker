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
    func fetchSummaryStats(completion: @escaping (SummaryStats?, Error?) -> Void) {
        provider.request(CovidTarget.fetchSummaryStats, completion: { (response) in
            switch response {
            case .failure(let error):
                completion(nil, error)
            case .success(let response):
                do {
                    let decodedData = try self.translationLayer.decode(SummaryStats.self, fromData: response.data)
                    completion(decodedData, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        })
    }
    
    func fetchCountryDetails(slug: String, completion: @escaping ([CountryStats]?, Error?) -> Void) {
        provider.request(CovidTarget.fetchCountryDetails(countrySlug: slug), completion: { (response) in
            switch response {
            case .failure(let error):
                completion(nil, error)
            case .success(let response):
                do {
                    let data = self.translationLayer.decodeSafelyArray(of: CountryStats.self, from: response.data)
                    completion(data, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        })
    }
}
