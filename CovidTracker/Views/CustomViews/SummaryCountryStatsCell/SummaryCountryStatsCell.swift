//
//  SummaryCountryStatsCell.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class SummaryCountryStatsCell: UITableViewCell {
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configureCell(countryStats: CountryStats, date: Date) {
        countryNameLabel.text = countryStats.country.name
        let totalRecord = countryStats.record
        confirmedLabel.text = totalRecord.confirmed.formattedWithSeparator
        recoveredLabel.text = totalRecord.recovered.formattedWithSeparator
        deathsLabel.text = totalRecord.deaths.formattedWithSeparator
        dateLabel.text = date.string
    }
}

extension UITableViewCell: UINibable {
    static func uiNib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
