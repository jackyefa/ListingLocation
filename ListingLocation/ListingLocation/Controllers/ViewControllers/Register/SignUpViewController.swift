//
//  SignUpViewController.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: BaseViewController {
    
    @IBOutlet var txtName: LLTextField?
    @IBOutlet var txtEmail: LLTextField?
    @IBOutlet var txtPassword: LLTextField?
    @IBOutlet var txtConfirmPassword: LLTextField?
    @IBOutlet var containerView: UIView?
    @IBOutlet var signUpBtn: LLButton?
    
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
        self.txtName?.initiliase_customTextField_with_blue_background()
        self.txtEmail?.initiliase_customTextField_with_blue_background()
        self.txtPassword?.initiliase_customTextField_with_blue_background()
        self.txtConfirmPassword?.initiliase_customTextField_with_blue_background()
        self.containerView?.layer.borderWidth = 3
        self.containerView?.layer.borderColor = UIColor.appBlueThemeColor().cgColor
        self.containerView?.layer.masksToBounds = true
        self.signUpBtn?.initiliseBtnWithRedBoreder()
    }
    
    // MARK:- API CALL - USER REGISTER
    
    func userSignup_apiCall() {
        let apiParams: NSDictionary = ["name": self.txtName!.text!,"password": self.txtPassword!.text!, "email": self.txtEmail!.text!]
        
        APIManager.sharedAPIManager.user_signUp_apiCall(apiParams, success:{(responseDictionary: NSDictionary) -> () in
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: SIGNUP_SUCCESS_MESSAGE, handler: {(objAlertAction: UIAlertAction!) -> Void in
                self.navigateToDashboard()
            })
            self.present(self.alertListingLocation!, animated: true, completion: nil)
        }, failure: {(error: NSError) -> () in
                self.showPopupWith_title_message(strTitle: appTitle, strMessage: error.localizedDescription)
        })
    }
    
    // MARK:- Button Tap Action
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let validationError: String = self.validateTextFiedText()
        validationError.isEmpty ? self.userSignup_apiCall() : self.showPopupWith_title_message(strTitle: appTitle, strMessage: validationError)
    }
    
    // MARK:- Common Methods
    
    func configureComponentLayout() {
        self.title = "Sign Up"
    }
    
    func validateTextFiedText() -> String {
        var validateError: String = String()
        if self.txtName!.text!.isEmpty {
            validateError = "Please input name."
        }else if self.txtEmail!.text!.isEmpty {
            validateError = "Please input email address."
        }else if !self.txtEmail!.text!.isValidEmailAddress() {
            validateError = "Please input valid email address."
        }else if self.txtPassword!.text!.isEmpty {
            validateError = "Please input valid password."
        }else if self.txtPassword!.text! != self.txtConfirmPassword!.text!{
            validateError = "Passwords did not matched."
        }
        return validateError
    }
    
    func navigateToDashboard(){
        self.view.endEditing(true)
        let dashboardVc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVc") as! DashboardViewController
        self.navigationController?.pushViewController(dashboardVc, animated: true)
    }
    
}



