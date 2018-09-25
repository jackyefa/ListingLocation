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

protocol ListingFormDelegate{
    func moveAnnotationView()
}

class ListingFormViewController: BaseViewController {
    
    var listingFormDelegate: ListingFormDelegate?
    @IBOutlet var listing_scroll_view: UIScrollView?
    @IBOutlet var property_image: UIImageView?
    var propertyImage: UIImage?
    @IBOutlet var custom_header_view: UIView?
    @IBOutlet var proprtyAddressTxt: LLTextField?
    @IBOutlet var unitTxt: LLTextField?
    @IBOutlet var cityTxt: LLTextField?
    @IBOutlet var stateTxt: LLTextField?
    @IBOutlet var zipcodeTxt: LLTextField?
    @IBOutlet var segmentControl: UISegmentedControl?
    @IBOutlet var idNumberTxt: LLTextField?
    @IBOutlet var buildingName: LLTextField?
    @IBOutlet var countryName: LLTextField?
    @IBOutlet var submitBtn: LLButton?
    
    var apiParams: NSDictionary?
    var selectedAnnotation: MKPointAnnotation?
    var callBackPropertyID: Int64?
    let geoCoder = CLGeocoder()
    var location_coordinate = CLLocationCoordinate2D()
    var location = CLLocation()
    
    // MARK:- Life Cycle Methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.reverseGeocoding()
        self.configureComponentsLayout()
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
            if((responseDictionary["id"]) != nil){
                self.callBackPropertyID = responseDictionary["id"] as? Int64
            }
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: LISTING_ADDED_MESSAGE, handler: {(objAlertAction: UIAlertAction!) -> Void in
                self.storePropertyImage()
            })
            self.present(self.alertListingLocation!, animated: true, completion: nil)
            
        }, failure: {(error: NSError) -> () in
            self.showPopupWith_title_message(strTitle: appTitle, strMessage: error.localizedDescription)
        })
    }
    
    func storePropertyImage(){
        if let image = self.propertyImage {
            UIImageWriteToSavedPhotosAlbum((image), self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelPicker(){
        self.view.endEditing(true)
    }
    
    // MARK:- Button tap actions.
    
    @IBAction func cancelBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        self.listingFormDelegate?.moveAnnotationView()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton){
        self.view.endEditing(true)
        self.listingFormDelegate?.moveAnnotationView()
        let validationError: String = self.validateTextFiedText()
        validationError.isEmpty ? self.addListing_api_call() : self.showPopupWith_title_message(strTitle: appTitle, strMessage: validationError)
    }
    
    @IBAction func sale_rent_Changed(segControl: UISegmentedControl) {
        if segControl.selectedSegmentIndex == 0 {
            self.segmentControl?.tag = 10
        }else {
            self.segmentControl?.tag = 20
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
        if (self.segmentControl?.tag == 10){
            dictParams["property_type"] = "sale"
        }else{
            dictParams["property_type"] = "rent"
        }
        dictParams["country"] = self.countryName!.text!
        dictParams["building_name"] = self.buildingName!.text!
        
        if (selectedAnnotation?.coordinate != nil){
            dictParams["latitude"] = self.selectedAnnotation?.coordinate.latitude
            dictParams["longitude"] = self.selectedAnnotation?.coordinate.longitude
        }
        if let image: UIImage = self.property_image?.image {
            let imageData: NSData = UIImagePNGRepresentation(image)! as NSData
            let strBase64:String = imageData.base64EncodedString(options: .lineLength64Characters)
            dictParams["image"] = strBase64
        }else {
            dictParams["image"] = ""
        }
        return ["property": dictParams]
    }
    
    func configureComponentsLayout(){
        self.segmentControl?.tag = 10
        self.segmentControl?.layer.borderWidth = 1.5
        self.segmentControl?.layer.borderColor = UIColor.appRedButtonColor().cgColor
        self.property_image?.layer.cornerRadius = 4
        self.property_image?.layer.borderWidth = 0.4
        self.property_image?.layer.borderColor = UIColor.lightGray.cgColor
        
        if (propertyImage != nil){
            self.property_image?.image = propertyImage
        }
        self.submitBtn?.initiliseBtnWithRedBoreder()
        //Scroll view
        self.listing_scroll_view?.layer.cornerRadius = 8
        self.listing_scroll_view?.layer.borderColor = UIColor.appBlueThemeColor().cgColor
        self.listing_scroll_view?.layer.borderWidth = 2
        //TextFields
        self.proprtyAddressTxt?.initiliase_customTextField_with_blue_background()
        self.unitTxt?.initiliase_customTextField_with_blue_background()
        self.cityTxt?.initiliase_customTextField_with_blue_background()
        self.stateTxt?.initiliase_customTextField_with_blue_background()
        self.zipcodeTxt?.initiliase_customTextField_with_blue_background()
        self.idNumberTxt?.initiliase_customTextField_with_blue_background()
        self.buildingName?.initiliase_customTextField_with_blue_background()
        self.countryName?.initiliase_customTextField_with_blue_background()
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
        }else if self.zipcodeTxt!.text!.isEmpty{
            validateError = "Please enter zipcode."
        }
        return validateError
    }
    
    func reverseGeocoding(){
        location = CLLocation(latitude: location_coordinate.latitude, longitude: location_coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            if let state = placeMark.administrativeArea {
                self.stateTxt?.text = state
            }
            if let address = placeMark.name {
                self.proprtyAddressTxt?.text = address
            }
            if let city = placeMark?.addressDictionary!["City"] {
                self.cityTxt?.text = city as? String
            }
            if let zip = placeMark.postalCode {
                self.zipcodeTxt?.text = zip
            }
            if let country = placeMark.country {
                self.countryName?.text = country
            }
        })
    }
    
    // Method for storing image in photos library with error handling.
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: error.localizedDescription)
            self.present(self.alertListingLocation!, animated:true, completion:nil)
        } else {
        }
    }
    
}
