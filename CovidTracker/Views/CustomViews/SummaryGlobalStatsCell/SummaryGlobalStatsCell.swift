//
//  SummaryGlobalStatsCell.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class SummaryGlobalStatsCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    
    func configureCell(globalStats: SummaryRecord) {
//        dateLabel.text = SummaryRecord.date
        let totalRecords = globalStats.totalRecords
        confirmedLabel.text = totalRecords.confirmed.formattedWithSeparator
        recoveredLabel.text = totalRecords.recovered.formattedWithSeparator
        deathsLabel.text = totalRecords.deaths.formattedWithSeparator
    }
    
}
