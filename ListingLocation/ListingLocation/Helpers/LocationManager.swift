//
//  LocationManager.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationServiceDelegate {
    func tracingLocation(_ currentLocation: CLLocation)
    func tracingLocationDidFailWithError(_ title: String, errorMessage: String)
}

class LocationManager: NSObject {
    
    static let sharedInstance: LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var delegate: LocationServiceDelegate?
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        guard self.locationManager != nil else {
            return
        }
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // you have 2 choice
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            self.locationManager?.requestAlwaysAuthorization()
        }
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        self.locationManager?.distanceFilter = 200 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        self.locationManager?.pausesLocationUpdatesAutomatically = false
        self.locationManager?.delegate = self
    }
    
    // MARK: - Start/Stop Updating location methods
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    // MARK: - Common methods
    
    func showRequestDeniedAlertView(_ title: String, message: String) {
        let locationErrorMessage: UIAlertController = UIAlertController.alertWithTitleAndMessage(title: title,message: message, handler:{(objAlertAction : UIAlertAction!) -> Void in
        })
        objWindow.rootViewController?.present(locationErrorMessage, animated: true, completion: nil)
    }
    
    // MARK: - Private functions
    
    fileprivate func updateLocation(_ currentLocation: CLLocation){
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocation(currentLocation)
    }
    
    fileprivate func updateLocationDidFailWithError(_ title: String, errorMessage: String) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocationDidFailWithError(title, errorMessage: errorMessage)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        // singleton for get last(current) location
        currentLocation = location
        // use for real time update location
        updateLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // do on error
        updateLocationDidFailWithError("Location Error", errorMessage: error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            self.locationManager?.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            self.startUpdatingLocation()
            break
        case .authorizedAlways:
            self.startUpdatingLocation()
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            updateLocationDidFailWithError("Access Restricted!", errorMessage: "You have disabled location access for the happyapp, please enable location services from settings.")
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            updateLocationDidFailWithError("Access Restricted!", errorMessage: "You have denied location access for happyapp, please grant the access from settings.")
            break
        }
    }
}
