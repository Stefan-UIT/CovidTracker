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
                    let optionalData = try self.translationLayer.decode([OptionalObject<CountryStats>].self, fromData: response.data)
                    let data = optionalData.compactMap { $0.value }
                    completion(data, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        })
    }
}

public struct OptionalObject<Base: Decodable>: Decodable {
    public let value: Base?

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            self.value = nil
        }
    }
}
