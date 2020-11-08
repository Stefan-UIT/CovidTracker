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
        print(Environment.serverURL.absoluteString)
        return Environment.serverURL
    }
    
    var headers: [String: String]? {
        return [ Keys.contentType: Keys.applicationJson ]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

public enum Environment {
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()

  static let serverURL: URL = {
    guard let rootURLstring = Environment.infoDictionary["SERVER_URL"] as? String else {
      fatalError("Root URL not set in plist for this environment")
    }
    guard let url = URL(string: rootURLstring) else {
      fatalError("Root URL is invalid")
    }
    return url
  }()
}
