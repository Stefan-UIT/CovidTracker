//
//  CountryDetailedStatsCell.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/13/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class CountryDetailedStatsCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    func configureCell(countryStats: CountryStats) {
        dateLabel.text = countryStats.date.string
        activeLabel.text = countryStats.record.active.formattedWithSeparator
        deathsLabel.text = countryStats.record.deaths.formattedWithSeparator
        confirmedLabel.text = countryStats.record.confirmed.formattedWithSeparator
        recoveredLabel.text = countryStats.record.recovered.formattedWithSeparator
    }
}
