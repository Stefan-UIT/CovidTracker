//
//  SummaryCountryStatsCell.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit
import Charts

class SummaryCountryStatsCell: UITableViewCell {
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupChartsUI()
    }
    
    func configureCell(countryStats: CountryStats, date: Date) {
        countryNameLabel.text = countryStats.country.name
        let totalRecord = countryStats.record
        confirmedLabel.text = totalRecord.confirmed.formattedWithSeparator
        recoveredLabel.text = totalRecord.recovered.formattedWithSeparator
        deathsLabel.text = totalRecord.deaths.formattedWithSeparator
        
        loadChartData(record: totalRecord)
    }
    
    private func setupChartsUI() {
        // legend is footer description
        pieChartView.legend.enabled = false
        pieChartView.isUserInteractionEnabled = false
    }
    
    private func loadChartData(record: Record) {
        let values = [
            record.confirmed,
            record.recovered,
            record.deaths
        ]
        
        // 1. Set ChartDataEntry
        let dataEntries: [ChartDataEntry] = values.map({
            PieChartDataEntry(value: Double($0), label: "")
        })
        
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = [
            UIColor.covidPink.withAlphaComponent(0.9),
            UIColor.covidGreen.withAlphaComponent(0.9),
            UIColor.covidBlack.withAlphaComponent(0.9)
        ]
        pieChartDataSet.drawIconsEnabled = false
        pieChartDataSet.selectionShift = 0
        pieChartDataSet.drawValuesEnabled = false
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        // 4. Assign it to the chart’s data
        pieChartView.data = pieChartData
    }
}
