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
        provider.request(CovidTarget.fetchSummaryStats, completion: { [weak self] (response) in
            guard let strongSelf = self else { return }
            strongSelf.handleSingleData(response: response,
                                  completion: completion)
        })
    }
    
    func fetchCountryDetails(slug: String, completion: @escaping ([CountryStats]?, Error?) -> Void) {
        provider.request(CovidTarget.fetchCountryDetails(countrySlug: slug), completion: { (response) in
            switch response {
            case .failure(let error):
                completion(nil, error)
            case .success(let response):
                let data = self.translationLayer.decodeSafelyArray(of: CountryStats.self, from: response.data)
                completion(data, nil)
            }
        })
    }
}

// Support functions
extension CovidService {
    func handleSingleData<T: Decodable>(response: Result<Moya.Response, MoyaError>,
                                        completion: @escaping (T?, Error?) -> Void) {
        switch response {
        case .failure(let error):
            completion(nil, error)
        case .success(let response):
            do {
                let decodedData = try self.translationLayer.decode(T.self, fromData: response.data)
                completion(decodedData, nil)
            } catch let error {
                completion(nil, error)
            }
        }
    }
}
