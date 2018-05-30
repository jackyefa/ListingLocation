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
        
    }
    
    // MARK:- Button tap actions and update_profile API_call
    
    @IBAction func cancelBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateBtnTapped(_ sender: UIButton){
        let apiParams: NSDictionary = ["name": self.nameTxt!.text!, "phone": self.phoneTxt!.text!, "address": self.addressTxt!.text!]
        
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
        self.nameTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.phoneTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.addressTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        
        //Default name, address and phone
        if !(name.isEmpty){
            self.nameTxt?.text = name
        }
        if(phone != 0){
            phoneTxt?.text = String(phone)
        }
        if !(address.isEmpty){
            self.addressTxt?.text = address
        }
    }

}
