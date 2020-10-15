//
//  CountryDetailedStatsViewController.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/13/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit
import MapKit

class CountryDetailedStatsViewController: BaseViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CountryDetailedStatsViewModel!
    var countryStats: CountryStats!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initTableView()
        setupUI()
    }
    
    private func setupUI() {
        setupMapView()
        titleLabel.text = countryStats.country.name
        subtitleLabel.text = countryStats.country.slug
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

// MARK: - UITableViewDelegate
extension CountryDetailedStatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

// MARK: - UITableViewDataSource
extension CountryDetailedStatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.statsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        countryStatsCell(tableView, atIndexPath: indexPath)
    }
    
    private func countryStatsCell(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> CountryDetailedStatsCell {
        let countryStats = viewModel.statsArray[indexPath.row]
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
    }
    
    func viewModel(_ viewModel: CountryDetailedStatsViewModel, didFailWithError error: Error) {
        showAlert(message: error.localizedDescription)
    }
}
