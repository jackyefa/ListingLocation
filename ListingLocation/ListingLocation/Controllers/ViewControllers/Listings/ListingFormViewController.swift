//
//  ListingFormViewController.swift
//  ListingLocation
//
//  Created by Apple on 16/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class ListingFormViewController: BaseViewController {
    
    @IBOutlet var container_view: UIView?
    @IBOutlet var custom_header_view: UIView?
    @IBOutlet var proprtyAddressTxt: LLTextField?
    @IBOutlet var unitTxt: LLTextField?
    @IBOutlet var commonAddressTxt: LLTextField?
    @IBOutlet var sale_rent_txt: LLTextField?
    @IBOutlet var idNumberTxt: LLTextField?
    var selectedAnnotation: MKPointAnnotation?
    var geocoder = CLGeocoder()
    
    // MARK:- Life Cycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureComponentsLayout()
        self.userFriendlyAddress()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    // MARK:- Button tap actions.
    
    @IBAction func cancelBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Geocoding to make address from lat/long
    
    func userFriendlyAddress(){
        guard let lat = selectedAnnotation?.coordinate.latitude else { return }
        guard let lng = selectedAnnotation?.coordinate.longitude else { return }
        let location = CLLocation(latitude: lat, longitude: lng)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                if let commonAddress = placemark.administrativeArea{
                    self.commonAddressTxt?.text = ("\(String(describing: placemark.locality!)), \(commonAddress), \(String(describing: placemark.postalCode!))")
                }
                if let localAddress = placemark.name{
                    self.proprtyAddressTxt?.text = localAddress
                }
            }
        }
    }
    
    // MARK:- Common Methods
    
    func configureComponentsLayout(){
        self.container_view?.layer.cornerRadius = 8
        self.container_view?.clipsToBounds = true
        self.proprtyAddressTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.unitTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.commonAddressTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.sale_rent_txt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.idNumberTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
    }

}
