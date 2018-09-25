//
//  ProfileViewController.swift
//  ListingLocation
//
//  Created by Apple on 14/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

class ProfileViewController: BaseViewController {
    
    @IBOutlet var fullNameTxt: LLTextField?
    @IBOutlet var phoneNumberTxt: LLTextField?
    @IBOutlet var addressTxt: LLTextField?
    @IBOutlet var emailTxt: LLTextField?
    @IBOutlet var unitTxt: LLTextField?
    @IBOutlet var cityTxt: LLTextField?
    @IBOutlet var stateTxt: LLTextField?
    @IBOutlet var zipcodeTxt: LLTextField?
    @IBOutlet var containerView: UIView?
    var userProfile: User?
    @IBOutlet var passwordBnt: LLButton?
    @IBOutlet var rateUsBnt: LLButton?
    @IBOutlet var reportABugBnt: LLButton?
    @IBOutlet var termsOfUseBtn: LLButton?
    @IBOutlet var privacyPolicyBnt: LLButton?
    @IBOutlet var flyoverCoverageBnt: LLButton?
    @IBOutlet var updateProfileBnt: LLButton?
    
    
    // MARK:- Life Cycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigationBarDefaulyLayoutView()
        self.userProfileApiCall()
        self.showIconBackOnNavigationBar()
        self.configureComponentsLayout()
        
        //Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(configureComponentsLayout), name: UPDATE_USER_DETAILS_NOTIFICATION, object: nil)
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
        self.fullNameTxt?.initiliase_customTextField_with_blue_background()
        self.phoneNumberTxt?.initiliase_customTextField_with_blue_background()
        self.addressTxt?.initiliase_customTextField_with_blue_background()
        self.emailTxt?.initiliase_customTextField_with_blue_background()
        self.unitTxt?.initiliase_customTextField_with_blue_background()
        self.cityTxt?.initiliase_customTextField_with_blue_background()
        self.stateTxt?.initiliase_customTextField_with_blue_background()
        self.zipcodeTxt?.initiliase_customTextField_with_blue_background()
        self.containerView?.layer.borderWidth = 3
        self.containerView?.layer.borderColor = UIColor.appBlueThemeColor().cgColor
        self.containerView?.layer.masksToBounds = true
        self.passwordBnt?.initiliseBtnWithRedBoreder()
        self.rateUsBnt?.initiliseBtnWithRedBoreder()
        self.reportABugBnt?.initiliseBtnWithRedBoreder()
        self.termsOfUseBtn?.initiliseBtnWithRedBoreder()
        self.privacyPolicyBnt?.initiliseBtnWithRedBoreder()
        self.flyoverCoverageBnt?.initiliseBtnWithRedBoreder()
        self.updateProfileBnt?.initiliseBtnWithRedBoreder()
    }
    
    // MARK:- API_CALL
    
    func userProfileApiCall(){
        
        APIManager.sharedAPIManager.user_Profile_apiCall(emptyParams, success:{(responseDictionary: User) -> () in
           self.userProfile = responseDictionary
            self.configureComponentsLayout()
            
        }, failure: {(error: NSError) -> () in
            self.showPopupWith_title_message(strTitle: appTitle, strMessage: error.localizedDescription)
        })
    }
    
    // MARK:- Button tap actions
    
    @IBAction func passwordBtnTapped(_ sender: UIButton){
        let updatePasswordVcObj: UpdatePasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "UpdatePasswordVc") as! UpdatePasswordViewController
        updatePasswordVcObj.modalPresentationStyle = .overCurrentContext
        updatePasswordVcObj.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(updatePasswordVcObj, animated: true, completion: nil)
    }
    
    @IBAction func rateUsBtnTapped(_ sender: UIButton){
        
    }
    
    @IBAction func reportABugBtnTapped(_ sender: UIButton){
        self.sendEmail()
    }
    
    @IBAction func termsOfUse(_ sender: UIButton){
        let termsOfUseVcObj: TermsOfUseViewController = self.storyboard?.instantiateViewController(withIdentifier: "TermsOfUseVc") as! TermsOfUseViewController
        termsOfUseVcObj.modalTransitionStyle = .crossDissolve
        termsOfUseVcObj.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(termsOfUseVcObj, animated: true, completion: nil)
    }
    
    @IBAction func privacyPolicyBtnTapped(_ sender: UIButton){
        let privacyPolicyVcObj: PrivacyPolicyViewController = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVc") as! PrivacyPolicyViewController
        privacyPolicyVcObj.modalPresentationStyle = .overCurrentContext
        privacyPolicyVcObj.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(privacyPolicyVcObj, animated: true, completion: nil)
    }
    
    @IBAction func flyoverCoverageBtnTapped(_ sender: UIButton){
        let flyoverCoverageVcObj: FlyoverCoverageViewController = self.storyboard?.instantiateViewController(withIdentifier: "FlyoverCoverageVc") as! FlyoverCoverageViewController
        flyoverCoverageVcObj.modalPresentationStyle = .overCurrentContext
        flyoverCoverageVcObj.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(flyoverCoverageVcObj, animated: true, completion: nil)
    }
    
    @IBAction func updateProfileBtnTapped(_ sender: UIButton){
        let apiParams: NSDictionary = ["name": self.fullNameTxt!.text!, "phone": self.phoneNumberTxt!.text!, "address": self.addressTxt!.text!, "city": self.cityTxt!.text!, "state": self.stateTxt!.text!, "zipcode": self.zipcodeTxt!.text!, "address_2": self.unitTxt!.text!]
        
        if(self.fullNameTxt?.text?.isEmpty)!{
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: "Please input name.")
            self.present(self.alertListingLocation!, animated: true, completion: nil)
        }
        else{
            
            //USER_UPDATE_PROFILE_API
            
            APIManager.sharedAPIManager.user_updateProfile_apiCall(apiParams, success:{(responseDictionary: NSDictionary) -> () in
                
                self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: UPDATE_PROFILE_SUCCESS_MESSAGE, handler: {(objAlertAction: UIAlertAction!) -> Void in
                    
                    self.userProfileApiCall()
                    
                    if let user_name = self.fullNameTxt?.text{
                        name = user_name
                    }
                    if let phone_number = self.phoneNumberTxt?.text{
                        phone = phone_number
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
    
    @objc func configureComponentsLayout(){
        self.title = "My Profile"
        
        //Name and address
        if !(name.isEmpty){
            self.fullNameTxt?.text = name
        }
        if !(address.isEmpty){
            self.addressTxt?.text = address
        }
        if (!phone.isEmpty){
            self.phoneNumberTxt?.text = phone
        }
        self.emailTxt?.text = user_email
        if let city = self.userProfile?.city{
            self.cityTxt?.text = city
        }
        if let state = self.userProfile?.state{
            self.stateTxt?.text = state
        }
        if let zipcode = self.userProfile?.zipCode{
            self.zipcodeTxt?.text = zipcode
        }
        if let address_two = userProfile?.address_two{
            self.unitTxt?.text = address_two
        }
    }

}

// MARK: - MFMailViewController Delegate

extension ProfileViewController: MFMailComposeViewControllerDelegate{

    func sendEmail(){
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@mylistinglocation.com "])
            mail.setMessageBody("<p>WE WILL BE GLAD TO HEAR FROM YOU ABOUT REPORTING A BUG!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: "Something went wrong!")
            self.present(self.alertListingLocation!, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

