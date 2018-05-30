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
    @IBOutlet var btnSignUp: LLButton?
    @IBOutlet weak var topImageHeight: NSLayoutConstraint?
    
    // MARK:- Life Cycle Methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureComponentLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // AppUtility.lockOrientation(.landscape)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Don't forget to reset when view is being removed
       // AppUtility.lockOrientation(.all)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.txtName?.setupCustomTextFieldWith_ImageName("icon_user", withSecuredEntery: false)
        self.txtEmail?.setupCustomTextFieldWith_ImageName("icon_email", withSecuredEntery: false)
        self.txtPassword?.setupCustomTextFieldWith_ImageName("icon_password", withSecuredEntery: true)
        self.btnSignUp?.initializeButton_withRedTheme()
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
    
    @IBAction func signUpViaFacebookTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func signUpViaTwitterTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Common Methods
    
    func configureComponentLayout() {
        if self.view.frame.size.width != 320 {
            self.topImageHeight?.constant = 300.0
        }
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
        }
        return validateError
    }
    
    func navigateToDashboard(){
        self.view.endEditing(true)
        let dashboardVc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVc") as! DashboardViewController
        self.navigationController?.pushViewController(dashboardVc, animated: true)
    }
    
}



