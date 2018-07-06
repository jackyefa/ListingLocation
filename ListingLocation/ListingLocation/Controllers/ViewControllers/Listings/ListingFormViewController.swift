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
    var apiParams: NSDictionary?
    var selectedAnnotation: MKPointAnnotation?
    var geocoder = CLGeocoder()
    
    var propertTypeArray = ["Sale","Rent"]
    var propertyIndex: Int = 0
    var propertyPicker: UIPickerView = UIPickerView()
    
    // MARK:- Life Cycle Methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: "My Listing Location", message: LISTING_ADDED_MESSAGE, handler: {(objAlertAction: UIAlertAction!) -> Void in
                self.openAlertToStorePropertyImage()
                NotificationCenter.default.post(name: UPDATE_DASHBOARD_NOTIFICATION, object: nil)
            })
            self.present(self.alertListingLocation!, animated: true, completion: nil)
            
        }, failure: {(error: NSError) -> () in
            self.showPopupWith_title_message(strTitle: appTitle, strMessage: error.localizedDescription)
        })
    }
    
    func openAlertToStorePropertyImage(){
        self.alertListingLocation = UIAlertController.confirmAlertWithTwoButtonTitles(title: "My Listing Location", message: "Do you want to store image in your pictures? You can store it later from My Listings.", btnTitle1: "Yes", btnTitle2: "No", handler:
            {(objAlertAction : UIAlertAction!) -> Void in
                if let image = self.propertyImage {
                    UIImageWriteToSavedPhotosAlbum((image), self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                }
        })
        self.present(self.alertListingLocation!, animated: true, completion: nil)
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
        }
        else{
            dictParams["property_type"] = "rent"
        }
        
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
        self.property_image?.layer.cornerRadius = 4
        self.property_image?.layer.borderWidth = 0.4
        self.property_image?.layer.borderColor = UIColor.lightGray.cgColor
        
        if (propertyImage != nil){
            self.property_image?.image = propertyImage
        }
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
    
    // Method for storing image in photos library with error handling.
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: error.localizedDescription)
            self.present(self.alertListingLocation!, animated:true, completion:nil)
        } else {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: "My Listing Location", message: "The image had been stored in your pictures.")
            self.present(self.alertListingLocation!, animated: true, completion: nil)
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


