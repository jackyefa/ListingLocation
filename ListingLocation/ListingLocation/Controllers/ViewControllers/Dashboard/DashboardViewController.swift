//
//  DashboardViewController.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import SideMenu

class DashboardViewController: BaseViewController {
    
    @IBOutlet var mapView: MKMapView?
    @IBOutlet var segmentControl: UISegmentedControl?
    let longPressRecognizer = UILongPressGestureRecognizer()
    
    // MARK:- Life Cycle Methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureComponentLayout()
        self.setupNavigationBarDefaulyLayoutView()
        self.showSearchIconOnNavigationBar()
        self.showMenuIconOnNavigationBar()
        self.setUpSideMenuAndDefaults()
        self.mapView?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //  AppUtility.lockOrientation(.landscape)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      //  AppUtility.lockOrientation(.all)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    // MARK: - API_call_methods
    
    @objc func logoutUser_Api_call(){
        self.alertListingLocation = UIAlertController.confirmAlertWithTwoButtonTitles(title: appTitle, message: "Are you sure you want to logout?", btnTitle1:"Yes", btnTitle2: "No", handler:{(objAlertAction : UIAlertAction!) -> Void in
            
            APIManager.sharedAPIManager.user_signOut_apiCall( success: {(responseDictionary: NSDictionary) -> () in
                NotificationCenter.default.post(name: INVALID_USER_ACCESS_TOKEN_NOTIFICATION, object: nil)
                self.showPopupWith_title_message(strTitle: appTitle, strMessage: LOGOUT_SUSSESS_MESSAGE)
            },failure: { (error: NSError) -> () in
                self.showPopupWith_title_message(strTitle: appTitle, strMessage: error.localizedDescription)
            })
        })
        self.present(self.alertListingLocation!, animated:true, completion:nil)
    }
    
    // MARK:- NavigationBar Bar button Methods
    
    func showSearchIconOnNavigationBar() {
        let searchBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_search"), style: .plain, target: self, action: #selector(showSearchLocationVc))
        searchBtn.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = searchBtn
    }
    
    func showMenuIconOnNavigationBar(){
        let menuBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: .plain, target: self, action: #selector(showLeftMenu))
        menuBtn.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = menuBtn
    }
    
    @objc func showSearchLocationVc() {
        let locationSearchVc = self.storyboard?.instantiateViewController(withIdentifier: "LocationSearchVc") as! LocationSearchViewController
        locationSearchVc.modalPresentationStyle = .overFullScreen
        locationSearchVc.locationSearchDelegate = self
        present(locationSearchVc, animated: true, completion: nil)
    }
    
    @objc func showLeftMenu(){
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    // MARK:- Button Tap Action
    
    @IBAction func mapTypeChanged(segControl: UISegmentedControl) {
        if segControl.selectedSegmentIndex == 0 {
            self.mapView?.mapType = .standard
            self.segmentControl?.tintColor = UIColor.appBlueThemeColor()
        }else {
            self.mapView?.mapType = .satelliteFlyover
            self.segmentControl?.tintColor = UIColor.white
        }
    }
    
    @IBAction func profileBtnTapped(_ sender: UIButton){
        let profileVcObj: ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVc") as! ProfileViewController
        self.navigationController?.pushViewController(profileVcObj, animated: true)
    }
    
    @IBAction func addListingsBtnTapped(_ sender: UIButton){
        let addListingsVcObj: AddListingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddListingsVc") as! AddListingsViewController
        self.navigationController?.pushViewController(addListingsVcObj, animated: true)
    }
    
    // MARK:- Common Methods
    
    func configureComponentLayout() {
        LocationManager.sharedInstance.delegate = self
        if let currentLocation = LocationManager.sharedInstance.currentLocation {
            self.showCurrentLocationOnMapView(currentLocation)
        }
        self.title = "Home"
        
        //Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUser_Api_call), name: LOGOUT_USER_NOTIFICATION, object: nil)
        
        //Long tap gesture __ drop pin
        self.longPressRecognizer.addTarget(self, action: #selector(dropPinOnLongPress))
        self.longPressRecognizer.minimumPressDuration = 1
        self.mapView?.addGestureRecognizer(longPressRecognizer)
    }
    
    func showCurrentLocationOnMapView(_ location: CLLocation) {
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        self.mapView?.setRegion(region, animated: true)
    }
    
    func setUpSideMenuAndDefaults(){
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.default.menuWidth = self.view.frame.width - 100
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuPushStyle = .defaultBehavior
        SideMenuManager.default.menuAnimationFadeStrength = 0.5
    }
    
    // MARK: - Drop pin on long press (1 sec)
    
    @objc func dropPinOnLongPress(_ gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state != .began {
            return
        }
        let touchPoint: CGPoint = gestureRecognizer.location(in: mapView!)
        let touchMapCoordinate: CLLocationCoordinate2D? = mapView?.convert(touchPoint, toCoordinateFrom: mapView)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: touchMapCoordinate!, span: span)
        mapView?.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchMapCoordinate!
        mapView?.addAnnotation(annotation)
    }
}

// MARK: - LocationServiceDelegate Delegate methods

extension DashboardViewController : LocationServiceDelegate {
    
    func tracingLocation(_ currentLocation: CLLocation) {
        self.showCurrentLocationOnMapView(currentLocation)
    }
    
    func tracingLocationDidFailWithError(_ title: String, errorMessage: String) {
        self.showPopupWith_title_message(strTitle: title, strMessage: errorMessage)
    }
}

// MARK: - Implementing LocationSearchViewController delegate

extension DashboardViewController: LocationSearchDelegate{
    
    func send_location_with_coordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        
        let location = CLLocationCoordinate2D(latitude: coordinate.latitude,longitude: coordinate.longitude)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView?.setRegion(region, animated: true)
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        mapView?.addAnnotation(annotation)
    }
    
}

// MARK: - Mapview deleagte methods.

extension DashboardViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.isDraggable = true
            annotationView!.canShowCallout = false
        }
        else {
            annotationView!.annotation = annotation
        }
        let pinImage = UIImage(named: "pin")
        annotationView!.image = pinImage
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        switch (newState) {
        case .starting:
            view.dragState = .dragging
        case .ending, .canceling:
            view.dragState = .none
        default: break
        }
    }
}
