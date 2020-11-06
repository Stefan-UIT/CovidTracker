//
//  Translatable.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

enum JsonParseError: Error {
    case couldNotDecode
}

protocol Translatable {
    func decode<T: Decodable>(_ type: T.Type, fromData data: Data) throws -> T
    func decodeSafelyArray<T: Decodable>(of type: T.Type, from data: Data) -> [T]
}
