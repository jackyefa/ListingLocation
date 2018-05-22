//
//  BaseViewController.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class BaseViewController: UIViewController {
    
    var alertListingLocation: UIAlertController?
    
    // MARK:- Life Cycle Methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional before appear the view.
        self.initializeDefaultNotifications()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional before appear the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appear the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Do any additional setup after appear the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Navigation Bar Setup Methods
    
    func setupNavigationBarDefaulyLayoutView() {
        self.navigationController?.navigationBar.barTintColor = UIColor.appBlueThemeColor()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font:UIFont.boldFontOfSize(size: 19.0)]
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.hidesBackButton = true
    }
    
    func showIconBackOnNavigationBar() {
        let btnBack: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back"), style: .plain, target: self, action: #selector(backNavBarButtonTapped))
        btnBack.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = btnBack
    }
    
    @objc func backNavBarButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Common Alert View Methods
    
    func showPopupWith_error_message(_ error: NSError){
        DispatchQueue.main.async() {
            if error.code != 404 {
                self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: error.localizedDescription, handler:{(objAlertAction : UIAlertAction!) -> Void in
                })
                self.present(self.alertListingLocation!, animated: true, completion: nil)
            }
        }
    }
    
    func showPopupWith_title_message(strTitle:String, strMessage:String){
        DispatchQueue.main.async() {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: strTitle,message:strMessage, handler:{(objAlertAction : UIAlertAction!) -> Void in
            })
            self.present(self.alertListingLocation!, animated: true, completion: nil)
        }
    }
    
    func showBackNavAlertWith_title_message(strTitle:String, strMessage:String){
        DispatchQueue.main.async() {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: strTitle,message:strMessage, handler:{(objAlertAction : UIAlertAction!) -> Void in
                self.navigationController?.popViewController(animated: true)
            })
            self.present(self.alertListingLocation!, animated: true, completion: nil)
        }
    }
    
    func showBackToRootAlertWith_title_message(strTitle:String, strMessage:String){
        DispatchQueue.main.async() {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: strTitle,message:strMessage, handler:{(objAlertAction : UIAlertAction!) -> Void in
                self.navigationController?.popToRootViewController(animated: true)
            })
            self.present(self.alertListingLocation!, animated: true, completion: nil)
        }
    }
    
    //MARK:- Common Methods

    func logoutUser_fromApp() {
        self.alertListingLocation = UIAlertController.confirmAlertWithTwoButtonTitles(title: appTitle, message: "Are you sure you want to Logout?", btnTitle1:"Yes", btnTitle2: "No", handler:{(objAlertAction : UIAlertAction!) -> Void in
            NotificationCenter.default.post(name: INVALID_USER_ACCESS_TOKEN_NOTIFICATION, object: nil)
        })
        self.present(self.alertListingLocation!, animated:true, completion:nil)
    }
    
    func showNoDataLabelOnTableView(_ tableView: UITableView, labelText: String) {
        let messageLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        messageLabel.text = labelText
        messageLabel.textColor = UIColor.darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.normalFontOfSize(size: 15.0)
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel
    }
    
    func hideNoDataLabelFromTableView(_ tableView: UITableView) {
        tableView.backgroundView = nil
    }
    
    func navigateToRootViewController() {
        self.view.endEditing(true)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Application Notification methods
    
    @objc func logoutUserAndReset_allDataNotification(notification: Notification) {
        //Take Action on Notification
        name = ""
        id = Int64()
        phone = Int64()
        auth_token = ""
        user_email = ""
        address = ""
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Initialize Application Notifications Method
    
    func initializeDefaultNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUserAndReset_allDataNotification(notification:)), name: INVALID_USER_ACCESS_TOKEN_NOTIFICATION , object: nil)
    }
}

