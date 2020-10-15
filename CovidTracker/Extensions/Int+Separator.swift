//
//  Int+Separator.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
