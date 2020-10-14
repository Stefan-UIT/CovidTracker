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
        setupMapView()
        titleLabel.text = countryStats.country.name
        subtitleLabel.text = countryStats.country.slug
    }
    
    func setupMapView() {
        mapView.delegate = self
        let location = CLLocationCoordinate2D(latitude: -30.56, longitude: 22.94)
        let anotation = MKPointAnnotation()
        anotation.title = countryStats.country.name
        anotation.coordinate = location
        mapView.addAnnotation(anotation)
        mapView.showAnnotations([anotation], animated: true)
    }
    
    func initViewModel() {
        viewModel = CountryDetailedStatsViewModel(slug: countryStats.country.slug)
        viewModel.delegate = self
        viewModel.fetchCountryDetails()
    }
    
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryDetailedStatsCell.uiNib(),
        forCellReuseIdentifier: CountryDetailedStatsCell.identifier)
    }
}

extension CountryDetailedStatsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
}

extension CountryDetailedStatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

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

protocol CountryDetailedStatsViewModelDelegate: class {
    func willLoadData(in viewModel: CountryDetailedStatsViewModel)
    func didFinishFetchingData(in viewModel: CountryDetailedStatsViewModel)
    func didLoadDataSuccessfully(in viewModel: CountryDetailedStatsViewModel)
    func viewModel(_ viewModel: CountryDetailedStatsViewModel, didFailWithError error: Error)
}

class CountryDetailedStatsViewModel {
    private var provider: CovidNetworkable
    private (set) var statsArray: [CountryStats]
    var countrySlug: String
    weak var delegate: CountryDetailedStatsViewModelDelegate?
    
    init(slug: String,
         statsArray: [CountryStats] = [CountryStats](),
         provider: CovidNetworkable = CovidService()) {
        self.provider = provider
        self.countrySlug = slug
        self.statsArray = statsArray
    }
    
    func fetchCountryDetails() {
        delegate?.willLoadData(in: self)
        provider.fetchCountryDetails(slug: countrySlug) { [weak self] (responseData, error) in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didFinishFetchingData(in: strongSelf)
            guard let data = responseData else {
                strongSelf.delegate?.viewModel(strongSelf, didFailWithError: error!)
                return
            }
            strongSelf.statsArray = data.reversed()
            strongSelf.delegate?.didLoadDataSuccessfully(in: strongSelf)
        }
    }
}
