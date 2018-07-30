//
//  ProfileViewController.swift
//  ListingLocation
//
//  Created by Apple on 14/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class ProfileViewController: BaseViewController {
    
    @IBOutlet var shortNameLable: UILabel?
    @IBOutlet var userProfileTable: UITableView?
    @IBOutlet var nameLbl: UILabel?
    @IBOutlet var shortNameLbl: UILabel?
    @IBOutlet var addressLbl: UILabel?
    
    // MARK:- Life Cycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigationBarDefaulyLayoutView()
        self.showIconBackOnNavigationBar()
        self.configureComponentsLayout()
        self.showEditBtnOnNavigationBar()
        
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
    
    // MARK:- NavigationBar Bar button Methods
    
    func showEditBtnOnNavigationBar() {
        let searchBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: #selector(showUpdateProfileVc))
        searchBtn.title = "Edit"
        searchBtn.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = searchBtn
    }
    
    // MARK:- Common methods.
    
    @objc func configureComponentsLayout(){
        self.title = "My Profile"
        self.userProfileTable?.tableFooterView = UIView()
        self.shortNameLable?.layer.cornerRadius = (self.shortNameLable?.frame.size.height)!/2
        self.shortNameLable?.layer.masksToBounds = true
        
        //Name and address
        if !(name.isEmpty){
            self.nameLbl?.text = name
            self.shortNameLbl?.text = String(describing: name.first!).uppercased()
        }
        if !(address.isEmpty){
            self.addressLbl?.text = address
        }
    }
    
    @objc func showUpdateProfileVc(){
        let updateProfileVcObj: UpdateProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileVc") as! UpdateProfileViewController
        updateProfileVcObj.modalPresentationStyle = .overCurrentContext
        updateProfileVcObj.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(updateProfileVcObj, animated: true, completion: nil)
    }

}

// MARK:- Table view delegate and data source methods.

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let userDetailsCell = tableView.dequeueReusableCell(withIdentifier: "userDetails", for: indexPath) as! UserDetailsCell
            return userDetailsCell
            
        case 1:
            let passwordCell = tableView.dequeueReusableCell(withIdentifier: "password", for: indexPath) as! PasswordCell
            passwordCell.accessoryType = .disclosureIndicator
            return passwordCell
            
        case 2:
            let legalAndPolicyCell = tableView.dequeueReusableCell(withIdentifier: "legalAndPolicy", for: indexPath) as! LegalAndPolicyCell
            return legalAndPolicyCell
        default:
            print("default case..!!")
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
            
        case 0:
            self.showUpdateProfileVc()
            
        case 1:
            let updatePasswordVcObj: UpdatePasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "UpdatePasswordVc") as! UpdatePasswordViewController
            updatePasswordVcObj.modalPresentationStyle = .overCurrentContext
            updatePasswordVcObj.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(updatePasswordVcObj, animated: true, completion: nil)
            
        default:
            print("Any row selected!!")
        }
    }
}
