//
//  LeftMenuViewController.swift
//  ListingLocation
//
//  Created by Apple on 15/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class LeftMenuViewController: UIViewController {
    
    @IBOutlet var userImage: UIImageView?
    @IBOutlet var logoutBtn: UIButton?
    @IBOutlet var emailLbl: UILabel?
    @IBOutlet var nameLbl: UILabel?
    
    // MARK:- Life Cycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    }
    
    // MARK:- Button tap actions.
    
    @IBAction func addListingsBtnTapped(_ sender: UIButton){
        let addListingsVcObj: AddListingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddListingsVc") as! AddListingsViewController
        self.navigationController?.pushViewController(addListingsVcObj, animated: true)
    }
    
    @IBAction func profileBtnTapped(_ sender: UIButton){
        let profileVcObj: ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVc") as! ProfileViewController
        self.navigationController?.pushViewController(profileVcObj, animated: true)
    }
    
    @IBAction func logoutBtnTapped(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: LOGOUT_USER_NOTIFICATION, object: nil)
    }
    
    // MARK:- Common methods.
    
    @objc func configureComponentsLayout(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.userImage?.layer.cornerRadius = (self.userImage?.frame.size.width)!/2
        self.userImage?.layer.masksToBounds = true
        self.logoutBtn?.layer.cornerRadius = (self.logoutBtn?.frame.size.height)!/2
        self.logoutBtn?.layer.borderColor = UIColor.appBlueThemeColor().cgColor
        self.logoutBtn?.layer.borderWidth = 2
        self.logoutBtn?.layer.masksToBounds = true
        
        //email and name
        if !(user_email.isEmpty){
            emailLbl?.text = user_email
        }
        if !(name.isEmpty){
            nameLbl?.text = name
        }
    }

}
