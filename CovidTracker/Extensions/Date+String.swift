//
//  Date+String.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/13/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

extension Date {
    var string: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: self)
    }
}
