//
//  LoginViewController.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet var txtEmail: LLTextField?
    @IBOutlet var txtPassword: LLTextField?
    @IBOutlet var rememberMeBtn: UIButton?
    @IBOutlet var containerView: UIView?
    @IBOutlet var loginBtn: LLButton?
    @IBOutlet var signupBtn: LLButton?
    
    // MARK:- Life Cycle Methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureComponentLayout()
        if !(auth_token.isEmpty){
            self.navigateToDashboard()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBarDefaulyLayoutView()
        
        if !(remember_email.isEmpty){
            self.txtEmail?.text = remember_email
            self.rememberMeBtn?.tag = 1
            self.rememberMeBtn?.setImage(UIImage(named: "tick"), for: .normal)
            self.rememberMeBtn?.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.txtEmail?.text = ""
        self.txtPassword?.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.txtEmail?.initiliase_customTextField_with_blue_background()
        self.txtPassword?.initiliase_customTextField_with_blue_background()
        self.rememberMeBtn?.layer.borderColor = UIColor.darkGray.cgColor
        self.rememberMeBtn?.layer.borderWidth = 2
        self.rememberMeBtn?.layer.cornerRadius = 2
        self.title = "Sign In - Register"
        self.containerView?.layer.borderWidth = 3
        self.containerView?.layer.borderColor = UIColor.appBlueThemeColor().cgColor
        self.containerView?.layer.masksToBounds = true
    }
    
    // MARK:- API CALL - USER LOGIN
    
    func userLogin_apiCall() {
        
        let apiParams: NSDictionary = ["email": self.txtEmail!.text!, "password": self.txtPassword!.text!]
        
        APIManager.sharedAPIManager.user_signIn_apiCall(apiParams, success:{(userData: User) -> () in
            
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: LOGIN_SUCCESS_MESSAGE, handler: {(objAlertAction: UIAlertAction!) -> Void in
                self.navigateToDashboard()
                remember_email = self.rememberMeBtn?.tag == 1 ? (self.txtEmail?.text)! : ""
            })
            self.present(self.alertListingLocation!, animated: true, completion: nil)
            
        },failure:{(error: NSError) -> () in
            self.showPopupWith_title_message(strTitle: appTitle, strMessage: error.localizedDescription)
        })
        
    }
    
    // MARK:- Button Tap Action
    
    @IBAction func rememberMeTapped(_ sender: UIButton) {
        if sender.tag == 0{
            sender.tag = 1
            self.rememberMeBtn?.setImage(UIImage(named: "tick"), for: .normal)
            self.rememberMeBtn?.imageView?.contentMode = .scaleAspectFit
        }
        else{
            sender.tag = 0
            self.rememberMeBtn?.setImage(UIImage(named: ""), for: .normal)
        }
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let validationError: String = self.validateTextFiedText()
        validationError.isEmpty ? self.userLogin_apiCall() : self.showPopupWith_title_message(strTitle: appTitle, strMessage: validationError)
        
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let signUpVc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVc") as! SignUpViewController
        self.navigationController?.pushViewController(signUpVc, animated: true)
    }
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let forgotPasswordVc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVc") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(forgotPasswordVc, animated: true)
    }
    
    // MARK:- Common Methods
    
    func configureComponentLayout() {
        self.rememberMeBtn?.layer.cornerRadius = 4
        self.rememberMeBtn?.layer.masksToBounds = false
        self.signupBtn?.initiliseBtnWithRedBoreder()
        self.loginBtn?.initiliseBtnWithRedBoreder()
    }
    
    func validateTextFiedText() -> String {
        var validateError: String = String()
        if self.txtEmail!.text!.isEmpty {
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

