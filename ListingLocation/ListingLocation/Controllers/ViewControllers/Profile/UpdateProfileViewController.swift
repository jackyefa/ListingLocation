//
//  UpdateProfileViewController.swift
//  ListingLocation
//
//  Created by Apple on 21/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class UpdateProfileViewController: BaseViewController {
    
    @IBOutlet var container_view: UIView?
    @IBOutlet var updateBtn: UIButton?
    @IBOutlet var nameTxt: LLTextField?
    @IBOutlet var phoneTxt: LLTextField?
    @IBOutlet var addressTxt: LLTextField?
    @IBOutlet var rateUsBtn: LLButton?
    @IBOutlet var reportBugBtn: LLButton?
    
    // MARK:- Life Cycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureComponentsLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.nameTxt?.initiliase_customTextField_with_blue_background()
        self.phoneTxt?.initiliase_customTextField_with_blue_background()
        self.addressTxt?.initiliase_customTextField_with_blue_background()
        self.rateUsBtn?.initializeButton_withRedTheme()
        self.reportBugBtn?.initializeButton_withRedTheme()
    }
    
    // MARK:- Button tap actions and update_profile API_call
    
    @IBAction func cancelBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateBtnTapped(_ sender: UIButton){
        let apiParams: NSDictionary = ["name": self.nameTxt!.text!, "phone": self.phoneTxt!.text!, "address": ""]
        
        if(self.nameTxt?.text?.isEmpty)!{
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: "Please input name.")
            self.present(self.alertListingLocation!, animated: true, completion: nil)
        }
        else{
            APIManager.sharedAPIManager.user_updateProfile_apiCall(apiParams, success:{(responseDictionary: NSDictionary) -> () in
                
                self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: UPDATE_PROFILE_SUCCESS_MESSAGE, handler: {(objAlertAction: UIAlertAction!) -> Void in
                    
                    if let user_name = self.nameTxt?.text{
                        name = user_name
                    }
                    if (self.phoneTxt?.text?.count == 0){
                        phone = Int64()
                    }else{
                        phone = Int64((self.phoneTxt?.text)!)!
                    }
                    if let user_adddress = self.addressTxt?.text{
                        address = user_adddress
                    }
                    NotificationCenter.default.post(name: UPDATE_USER_DETAILS_NOTIFICATION, object: nil)
                    self.dismiss(animated: true, completion: nil)
                })
                self.present(self.alertListingLocation!, animated: true, completion: nil)
                
            },failure:{(error: NSError) -> () in
                self.showPopupWith_title_message(strTitle: appTitle, strMessage: error.localizedDescription)
            })
        }
    }
    
    // MARK:- Common methods.
    
    func configureComponentsLayout(){
        self.container_view?.layer.cornerRadius = 8
        self.container_view?.clipsToBounds = true
        self.updateBtn?.layer.cornerRadius = 8
        
        //Default name, address and phone
        if !(name.isEmpty){
            self.nameTxt?.text = name
        }
        if(phone != 0){
            phoneTxt?.text = String(phone)
        }
        self.addressTxt?.text = user_email
    }

}
