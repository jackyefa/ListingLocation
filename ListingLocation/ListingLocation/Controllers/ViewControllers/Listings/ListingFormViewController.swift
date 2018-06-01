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
    
    @IBOutlet var property_image: UIImageView?
    var propertyImage: UIImage?
    @IBOutlet var custom_header_view: UIView?
    @IBOutlet var proprtyAddressTxt: LLTextField?
    @IBOutlet var unitTxt: LLTextField?
    @IBOutlet var cityTxt: LLTextField?
    @IBOutlet var stateTxt: LLTextField?
    @IBOutlet var zipcodeTxt: LLTextField?
    @IBOutlet var sale_rent_txt: LLTextField?
    @IBOutlet var idNumberTxt: LLTextField?
    var apiParams: NSDictionary?
    var selectedAnnotation: MKPointAnnotation?
    var geocoder = CLGeocoder()
    
    var propertTypeArray = ["Sale", "Rent"]
    var propertyIndex: Int = 0
    var propertyPicker: UIPickerView = UIPickerView()
    
    // MARK:- Life Cycle Methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureComponentsLayout()
        self.userFriendlyAddress()
        self.setupPropertyTypePickerView()
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
    
    // MARK:- Add_Listing_API_call
    
    func addListing_api_call(){
        
        apiParams = self.getApiParamsToAddListing()
        
        APIManager.sharedAPIManager.user_addListing_apiCall(apiParams!, success:{(responseDictionary: NSDictionary) -> () in
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: LISTING_ADDED_MESSAGE, handler: {(objAlertAction: UIAlertAction!) -> Void in
                self.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: UPDATE_DASHBOARD_NOTIFICATION, object: nil)
            })
            self.present(self.alertListingLocation!, animated: true, completion: nil)
            
        }, failure: {(error: NSError) -> () in
            self.showPopupWith_title_message(strTitle: appTitle, strMessage: error.localizedDescription)
        })
    }
    
    //MARK: - Setup property type picker view.
    
    func setupPropertyTypePickerView(){
        self.propertyPicker.delegate = self
        self.propertyPicker.dataSource = self
        //Done button & Cancel button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePropertyPicker)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))],
                         animated: false)
        // add toolbar and textField
        self.sale_rent_txt?.inputAccessoryView = toolbar
        self.sale_rent_txt?.inputView = self.propertyPicker
    }
    
    @objc func donePropertyPicker(){
        self.view.endEditing(true)
        if self.propertyIndex < self.propertTypeArray.count {
            self.sale_rent_txt?.text = self.propertTypeArray[self.propertyIndex]
        }
    }
    
    @objc func cancelPicker(){
        self.view.endEditing(true)
    }
    
    // MARK:- Button tap actions.
    
    @IBAction func cancelBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton){
        self.view.endEditing(true)
        let validationError: String = self.validateTextFiedText()
        validationError.isEmpty ? self.addListing_api_call() : self.showPopupWith_title_message(strTitle: appTitle, strMessage: validationError)
    }
    
    @IBAction func panAnnotation(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
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
        if error != nil {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: "Unable to fetch location. Please enter desired fields for listing.")
            self.present(alertListingLocation!, animated: true, completion: nil)
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                if let city = placemark.locality{
                    self.cityTxt?.text = city
                }
                if let localAddress = placemark.name{
                    self.proprtyAddressTxt?.text = localAddress
                }
                if let state = placemark.administrativeArea{
                    self.stateTxt?.text = state
                }
                if let zipcode = placemark.postalCode{
                    self.zipcodeTxt?.text = zipcode
                }
            }
        }
    }
    
    // MARK:- Common Methods
    
    func getApiParamsToAddListing() -> NSDictionary{
        let dictParams: NSMutableDictionary = NSMutableDictionary()
        dictParams["address"] = self.proprtyAddressTxt!.text!
        dictParams["unit"] = self.unitTxt!.text!
        dictParams["city"] = self.cityTxt!.text!
        dictParams["state"] = self.stateTxt!.text!
        dictParams["zipcode"] = self.zipcodeTxt!.text!
        dictParams["id_number"] = self.idNumberTxt!.text!
        dictParams["property_type"] = self.sale_rent_txt!.text!
        
        if (selectedAnnotation?.coordinate != nil){
            dictParams["latitude"] = self.selectedAnnotation?.coordinate.latitude
            dictParams["longitude"] = self.selectedAnnotation?.coordinate.longitude
        }
        return ["property": dictParams]
    }
    
    func configureComponentsLayout(){
        self.proprtyAddressTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.unitTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.cityTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.stateTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.zipcodeTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.sale_rent_txt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.idNumberTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        
        self.property_image?.layer.cornerRadius = 4
        self.property_image?.layer.borderWidth = 1
        self.property_image?.layer.borderColor = UIColor.lightGray.cgColor
        
        if (propertyImage != nil){
            self.property_image?.image = propertyImage
        }
    }
    
    func validateTextFiedText() -> String {
        var validateError: String = String()
        if self.proprtyAddressTxt!.text!.isEmpty {
            validateError = "Please input address."
        }else if self.unitTxt!.text!.isEmpty {
            validateError = "Please input unit."
        }else if self.cityTxt!.text!.isEmpty {
            validateError = "Please input city."
        }else if self.stateTxt!.text!.isEmpty{
            validateError = "Please input estate."
        }else if self.sale_rent_txt!.text!.isEmpty{
            validateError = "Please mention property type."
        }
        return validateError
    }
    
    func addressToLatLong(){
        let geocoder = CLGeocoder()
        let addressString = "\(String(describing: self.proprtyAddressTxt?.text!)), \(String(describing: self.cityTxt?.text!)), \(String(describing: self.stateTxt?.text!))"
        geocoder.geocodeAddressString(addressString){
            placemarks, error in
            let placemark = placemarks?.first
            if (placemark?.location?.coordinate.latitude == nil){
                print("no!!")
            }else{
                print("yes!!")
            }
        }
    }
    
}

// MARK: - Pickerview delegate and data source

extension ListingFormViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.propertTypeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        self.propertyIndex = row
        return propertTypeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.propertyIndex = row
    }
}
