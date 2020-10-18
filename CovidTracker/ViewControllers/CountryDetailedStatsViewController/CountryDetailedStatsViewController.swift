//
//  CountryDetailedStatsViewController.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/13/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit
import MapKit
import Charts

class CountryDetailedStatsViewController: BaseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Properties
    var viewModel: CountryDetailedStatsViewModel!
    var countryStats: CountryStats!
    private var lineChart = LineChartView()
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initTableView()
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction func onSegmentedControlTouchUp(_ sender: UISegmentedControl) {
        let isDetailsSection = segmentedControl.selectedSegmentIndex == 0
        tableView.isHidden = !isDetailsSection
        lineChart.isHidden = isDetailsSection
        if !isDetailsSection {
            setupChartData()
            lineChart.animate(xAxisDuration: 1.5)
        }
    }
}

// MARK: - Private Helpers
private extension CountryDetailedStatsViewController {
    private func setupUI() {
        setupMapView()
        setupCharts()
        titleLabel.text = countryStats.country.name
        subtitleLabel.text = countryStats.country.slug
        lineChart.isHidden = true
        segmentedControl.isUserInteractionEnabled = false
    }
    
    private func setupCharts() {
        view.addSubview(lineChart)
        
        // setup chart constraints
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        lineChart.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        lineChart.widthAnchor.constraint(equalToConstant: Constants.Screen.width).isActive = true
        lineChart.heightAnchor.constraint(equalToConstant: Constants.Screen.width).isActive = true
        
        // setup chart properties
        lineChart.rightAxis.enabled = false
        lineChart.xAxis.gridLineDashLengths = [10, 10]
        lineChart.xAxis.gridLineDashPhase = 0
        lineChart.xAxis.drawLabelsEnabled = false
        lineChart.leftAxis.gridLineDashLengths = [5, 5]
    }
    
    private func setupMapView() {
        let location = CLLocationCoordinate2D(latitude: -30.56, longitude: 22.94)
        let anotation = MKPointAnnotation()
        anotation.title = countryStats.country.name
        anotation.coordinate = location
        mapView.addAnnotation(anotation)
        mapView.showAnnotations([anotation], animated: true)
    }
    
    private func initViewModel() {
        viewModel = CountryDetailedStatsViewModel(slug: countryStats.country.slug)
        viewModel.delegate = self
        viewModel.fetchCountryDetails()
    }
    
    private func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryDetailedStatsCell.uiNib(),
        forCellReuseIdentifier: CountryDetailedStatsCell.identifier)
    }
}

// MARK: - Line Charts
private extension CountryDetailedStatsViewController {
    func setupChartData() {
        let dataEntries = getDataEntries()
        let confirmedDataSet = lineChartDataSet(dataEntries: dataEntries.0,
                                                lineColor: .covidPink,
                                                label: "Confirmed")

        let recoveredDataSet = lineChartDataSet(dataEntries: dataEntries.1,
                                                lineColor: .covidGreen,
                                                label: "Recovered")
        
        let activeDataSet = lineChartDataSet(dataEntries: dataEntries.2,
                                             lineColor: .covidOrange,
                                             label: "Active")
        
        let chartData = LineChartData(dataSets: [confirmedDataSet, recoveredDataSet, activeDataSet])
        chartData.setDrawValues(false)
        lineChart.data = chartData
    }
    
    func lineChartDataSet(dataEntries: [ChartDataEntry], lineColor: UIColor, label: String) -> LineChartDataSet {
        let dataSet = LineChartDataSet(entries: dataEntries, label: label)
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 3
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.setColor(lineColor.withAlphaComponent(0.8))
        
        return dataSet
    }
    
    // swiftlint:disable large_tuple
    func getDataEntries() -> ([ChartDataEntry], [ChartDataEntry], [ChartDataEntry]) {
        var confirmedDataEntries: [ChartDataEntry] = []
        var recoveredDataEntries: [ChartDataEntry] = []
        var activeDataEntries: [ChartDataEntry] = []
        for (index, stats) in viewModel.statsArray.enumerated() {
            let confirmedEntry = ChartDataEntry(x: Double(index),
                                           y: Double(stats.record.confirmed))
            confirmedDataEntries.append(confirmedEntry)
            let recoveredEntry = ChartDataEntry(x: Double(index),
                                           y: Double(stats.record.recovered))
            recoveredDataEntries.append(recoveredEntry)
            let deathsEntry = ChartDataEntry(x: Double(index),
                                             y: Double(stats.record.active))
            activeDataEntries.append(deathsEntry)
        }
        return (confirmedDataEntries, recoveredDataEntries, activeDataEntries)
    }
    
}

// MARK: - UITableViewDelegate
extension CountryDetailedStatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

// MARK: - UITableViewDataSource
extension CountryDetailedStatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sortedStatsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        countryStatsCell(tableView, atIndexPath: indexPath)
    }
    
    private func countryStatsCell(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> CountryDetailedStatsCell {
        let countryStats = viewModel.sortedStatsArray[indexPath.row]
        let cell = tableView.dequeuCellOfType(CountryDetailedStatsCell.self)
        cell.configureCell(countryStats: countryStats)
        
        return cell
    }
}

// MARK: - CountryDetailedStatsViewModelDelegate
extension CountryDetailedStatsViewController: CountryDetailedStatsViewModelDelegate {
    func willLoadData(in viewModel: CountryDetailedStatsViewModel) {
        tableView.showLoadingIndicator()
    }
    func didFinishFetchingData(in viewModel: CountryDetailedStatsViewModel) {
        tableView.hideLoadingIndicator()
    }
    
    func didLoadDataSuccessfully(in viewModel: CountryDetailedStatsViewModel) {
        tableView.reloadData()
        segmentedControl.isUserInteractionEnabled = true
    }
    
    func viewModel(_ viewModel: CountryDetailedStatsViewModel, didFailWithError error: Error) {
        showAlert(message: error.localizedDescription)
    }
}
