//
//  ForgotPasswordViewController.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordViewController: BaseViewController {
    
    @IBOutlet var txtEmail: LLTextField?
    @IBOutlet var containerView: UIView?
    @IBOutlet var forgotPasswordBtn: LLButton?
    
    // MARK:- Life Cycle Methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureComponentLayout()
        self.showIconBackOnNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBarDefaulyLayoutView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.txtEmail?.initiliase_customTextField_with_blue_background()
        self.containerView?.layer.borderWidth = 3
        self.containerView?.layer.borderColor = UIColor.appBlueThemeColor().cgColor
        self.containerView?.layer.masksToBounds = true
        self.forgotPasswordBtn?.initiliseBtnWithRedBoreder()
    }
    
    // MARK:- API CALL - USER FORGOT PASSWORD
    
    func userForgotPassword_apiCall() {
        
        let apiParams: NSDictionary = ["email": self.txtEmail!.text!]
        
        APIManager.sharedAPIManager.user_forgotPassword_apiCall(apiParams, success:{(responseDictionary: NSDictionary) -> () in
            
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: FORGOT_PASSWORD_SUCCESS_MESSAGE, handler: {(objAlertAction: UIAlertAction!) -> Void in
                self.navigationController?.popViewController(animated: true)
            })
            self.present(self.alertListingLocation!, animated: true, completion: nil)
            
        },failure:{(error: NSError) -> () in
            self.showPopupWith_title_message(strTitle: appTitle, strMessage: error.localizedDescription)
        })
    }
    
    // MARK:- Button Tap Action
    
    @IBAction func resetPasswordTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let validationError: String = self.validateTextFiedText()
        validationError.isEmpty ? self.userForgotPassword_apiCall() : self.showPopupWith_title_message(strTitle: appTitle, strMessage: validationError)
    }
    
    // MARK:- Common Methods
    
    func configureComponentLayout() {
        self.title = "Forgot Password"
    }
    
    func validateTextFiedText() -> String {
        var validateError: String = String()
        if self.txtEmail!.text!.isEmpty {
            validateError = "Please input email address."
        }else if !self.txtEmail!.text!.isValidEmailAddress() {
            validateError = "Please input valid email address."
        }
        return validateError
    }
    
}

