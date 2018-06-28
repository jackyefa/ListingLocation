//
//  LocationSearchViewController.swift
//  ListingLocation
//
//  Created by Apple on 12/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation
import MapKit

protocol LocationSearchDelegate{
    func send_location_with_coordinate(coordinate: CLLocationCoordinate2D)
}

class LocationSearchViewController: UIViewController {
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var locationSearchDelegate: LocationSearchDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchCompleter.delegate = self
        self.configureComponentsLayout()
    }
    
    // MARK:- Button Tap Action
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.removeAnimate()
    }
    
    // MARK: - SHOW HIDE ANIMATIONS METHODS
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished){
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    // MARK: - Common methods
    
    func configureComponentsLayout(){
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white
    }
}

extension LocationSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}

extension LocationSearchViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension LocationSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
    
}

extension LocationSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearchRequest(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            self.locationSearchDelegate?.send_location_with_coordinate(coordinate: coordinate!)
            self.removeAnimate()
        }
    }
}

