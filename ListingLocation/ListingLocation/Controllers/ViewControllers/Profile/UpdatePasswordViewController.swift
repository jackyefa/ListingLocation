//
//  UpdatePasswordViewController.swift
//  ListingLocation
//
//  Created by Apple on 21/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class UpdatePasswordViewController: BaseViewController {
    
    @IBOutlet var container_view: UIView?
    @IBOutlet var currentPasswordTxt: LLTextField?
    @IBOutlet var newPasswordTxt: LLTextField?
    @IBOutlet var confirmPasswordTxt: LLTextField?
    @IBOutlet var updateBtn: UIButton?
    
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
    
    // MARK:- UPDATE PASSWORD_API_CALL.
    
    func userUpdatePassword_api_call(){
        let apiParams: NSDictionary = ["current_password": self.currentPasswordTxt!.text!, "new_password": self.newPasswordTxt!.text!]
        
        APIManager.sharedAPIManager.user_updatePassword_apiCall(apiParams, success:{(responseDictionary: NSDictionary) -> () in
            
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: UPDATE_PASSWORD_SUCCESS_MESSAGE, handler: {(objAlertAction: UIAlertAction!) -> Void in
                self.dismiss(animated: true, completion: nil)
            })
            self.present(self.alertListingLocation!, animated: true, completion: nil)
            
        },failure:{(error: NSError) -> () in
            self.showPopupWith_title_message(strTitle: appTitle, strMessage: error.localizedDescription)
        })
    }
    
    // MARK:- Button tap actions.
    
    @IBAction func cancelBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateBtnTapped(_ sender: UIButton){
        self.view.endEditing(true)
        let validationError: String = self.validateTextFiedText()
        validationError.isEmpty ? self.userUpdatePassword_api_call(): self.showPopupWith_title_message(strTitle: appTitle, strMessage: validationError)
    }
    
    // MARK:- Common methods.
    
    func configureComponentsLayout(){
        self.container_view?.layer.cornerRadius = 8
        self.container_view?.clipsToBounds = true
        self.updateBtn?.layer.cornerRadius = 8
        self.currentPasswordTxt?.initiliase_customTextField_with_blue_background()
        self.newPasswordTxt?.initiliase_customTextField_with_blue_background()
        self.confirmPasswordTxt?.initiliase_customTextField_with_blue_background()
    }
    
    func validateTextFiedText() -> String {
        var validateError: String = String()
        if self.currentPasswordTxt!.text!.isEmpty {
            validateError = "Please input current password."
        }else if self.newPasswordTxt!.text!.isEmpty {
            validateError = "Please input new password."
        }else if self.confirmPasswordTxt!.text!.isEmpty {
            validateError = "Please confirm the password."
        }else if self.newPasswordTxt!.text! != self.confirmPasswordTxt!.text!{
            validateError = "Password do not match."
        }
        return validateError
    }
    
}
