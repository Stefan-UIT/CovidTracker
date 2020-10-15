//
//  OptionalObject.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/15/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

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
