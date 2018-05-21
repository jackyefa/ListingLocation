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
    @IBOutlet var btnForgotPass: LLButton?
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
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.txtEmail?.setupCustomTextFieldWith_ImageName("icon_email", withSecuredEntery: false)
        self.btnForgotPass?.initializeButton_withRedTheme()
    }
    
    // MARK:- API CALL - USER FORGOT PASSWORD
    
    func userForgotPassword_apiCall() {
        
    }
    
    // MARK:- Button Tap Action
    
    @IBAction func resetPasswordTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let validationError: String = self.validateTextFiedText()
        validationError.isEmpty ? self.userForgotPassword_apiCall() : self.showPopupWith_title_message(strTitle: appTitle, strMessage: validationError)
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
        if self.txtEmail!.text!.isEmpty {
            validateError = "Please input email address."
        }else if !self.txtEmail!.text!.isValidEmailAddress() {
            validateError = "Please input valid email address."
        }
        return validateError
    }
    
}

