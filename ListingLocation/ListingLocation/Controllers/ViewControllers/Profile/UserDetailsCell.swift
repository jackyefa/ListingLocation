//
//  UserDetailsCell.swift
//  ListingLocation
//
//  Created by Apple on 15/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class UserDetailsCell: UITableViewCell {
    
    @IBOutlet var nameTxt: UITextField?
    @IBOutlet var emailTxt: UITextField?
    @IBOutlet var phoneTxt: UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupDetailsCell()
        //Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(setupDetailsCell), name: UPDATE_USER_DETAILS_NOTIFICATION, object: nil)
    }
    
    @objc func setupDetailsCell(){
        //Default name, email and phone
        if !(name.isEmpty){
            self.nameTxt?.text = name
        }
        if !(user_email.isEmpty){
            emailTxt?.text = user_email
        }
        if(phone != 0){
            phoneTxt?.text = String(phone)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
