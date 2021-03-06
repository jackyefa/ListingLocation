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
    @IBOutlet var annotBaseView: UIView?
    @IBOutlet var annotationImage: UIImageView?
    var locationCoordinate = CLLocationCoordinate2D()
    let pitch: CGFloat = 65
    let heading = 0.0
    var camera: MKMapCamera?
    var is_pin_moved: Bool = false
    
    // MARK:- Life Cycle Methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureComponentLayout()
        self.setupNavigationBarDefaulyLayoutView()
        self.showSearchIconAndAddIcon()
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.annotBaseView?.frame = CGRect(x: 50, y: 0, width: (self.annotBaseView?.frame.size.width)!, height: (self.annotBaseView?.frame.size.height)!)
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
    
    func showMenuIconOnNavigationBar(){
        let menuBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: .plain, target: self, action: #selector(showLeftMenu))
        menuBtn.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = menuBtn
    }
    
    func showSearchIconAndAddIcon(){
        let searchBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_search"), style: .plain, target: self, action: #selector(showSearchLocationVc))
        searchBtn.tintColor = UIColor.white
        
        let addBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(openaddListingVc))
        addBtn.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItems = [searchBtn, addBtn]
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
            self.mapView?.mapType = .satelliteFlyover
            self.segmentControl?.tintColor = UIColor.white
        }else {            
            self.mapView?.mapType = .standard
            self.segmentControl?.tintColor = UIColor.appBlueThemeColor()
        }
    }
    
    @IBAction func panAnnotation(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        self.is_pin_moved = true
    }
    
    @objc func openaddListingVc(){
        if(is_pin_moved){
            var screenshotImage :UIImage?
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }
            view.layer.render(in:context)
            screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            UIGraphicsBeginImageContextWithOptions((mapView?.frame.size)!, false, 0.0)
            screenshotImage?.draw(at: CGPoint(x: 0, y: 0))
            let croppedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let image = croppedImage {
                let listingFormVcObj: ListingFormViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListingFormVc") as! ListingFormViewController
                listingFormVcObj.propertyImage = image
                listingFormVcObj.listingFormDelegate = self
                listingFormVcObj.location_coordinate = locationCoordinate
                listingFormVcObj.modalPresentationStyle = .overCurrentContext
                listingFormVcObj.modalTransitionStyle = .crossDissolve
                self.navigationController?.present(listingFormVcObj, animated: true, completion: nil)
            }
        }else{
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: VIEW_MOVED_MESSAGE, handler: {(objAlertAction: UIAlertAction!) -> Void in
            })
            self.present(self.alertListingLocation!, animated: true, completion: nil)
        }
    }
    
    // MARK:- Common Methods
    
    func configureComponentLayout() {
        LocationManager.sharedInstance.delegate = self
        if let currentLocation = LocationManager.sharedInstance.currentLocation {
            self.showCurrentLocationOnMapView(currentLocation)
        }
        //Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUser_Api_call), name: LOGOUT_USER_NOTIFICATION, object: nil)
        self.mapView?.showsUserLocation = false
        self.title = "Home"
    }
    
    func showCurrentLocationOnMapView(_ location: CLLocation) {
        locationCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,longitude: location.coordinate.longitude)
        self.mapView?.isPitchEnabled = true
        camera = MKMapCamera(lookingAtCenter: locationCoordinate,
                             fromDistance: 200,
                             pitch: pitch,
                             heading: heading)
        mapView?.camera = camera!
    }
    
    func setUpSideMenuAndDefaults(){
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.default.menuWidth = self.view.frame.width/3 + 20
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuPushStyle = .defaultBehavior
        SideMenuManager.default.menuAnimationFadeStrength = 0.5
    }
    
}

// MARK: - ListingFormDelegate implementation

extension DashboardViewController: ListingFormDelegate{
    func moveAnnotationView() {
        self.annotBaseView?.frame = CGRect(x: 50, y: 0, width: (self.annotBaseView?.frame.size.width)!, height: (self.annotBaseView?.frame.size.height)!)
        self.is_pin_moved = false
    }
}

// MARK: - LocationServiceDelegate Delegate methods

extension DashboardViewController : LocationServiceDelegate {
    
    func tracingLocation(_ currentLocation: CLLocation) {
        self.showCurrentLocationOnMapView(currentLocation)
    }
    
    func tracingLocationDidFailWithError(_ title: String, errorMessage: String) {
    }
}

// MARK: - Implementing LocationSearchViewController delegate

extension DashboardViewController: LocationSearchDelegate{
    
    func send_location_with_coordinate(coordinate: CLLocationCoordinate2D) {
        self.annotBaseView?.frame = CGRect(x: 50, y: 0, width: (self.annotBaseView?.frame.size.width)!, height: (self.annotBaseView?.frame.size.height)!)
        locationCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude,longitude: coordinate.longitude)
        self.mapView?.isPitchEnabled = true
        camera = MKMapCamera(lookingAtCenter: locationCoordinate,
                             fromDistance: 200,
                             pitch: pitch,
                             heading: heading)
        mapView?.camera = camera!
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    }
}

