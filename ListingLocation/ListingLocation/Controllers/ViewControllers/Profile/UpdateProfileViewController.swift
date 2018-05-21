//
//  UpdateProfileViewController.swift
//  ListingLocation
//
//  Created by Apple on 21/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class UpdateProfileViewController: BaseViewController {
    
    @IBOutlet var container_view: UIView?
    @IBOutlet var updateBtn: UIButton?
    @IBOutlet var nameTxt: LLTextField?
    @IBOutlet var phoneTxt: LLTextField?
    @IBOutlet var addressTxt: LLTextField?
    
    // MARK:- Life Cycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureComponentsLayout()
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
    
    @IBAction func cancelBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Common methods.
    
    func configureComponentsLayout(){
        self.container_view?.layer.cornerRadius = 8
        self.container_view?.clipsToBounds = true
        self.updateBtn?.layer.cornerRadius = 8
        self.nameTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.phoneTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.addressTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        
        //Default name, email and phone
        if !(name.isEmpty){
            self.nameTxt?.text = name
        }
        
        if(phone != 0){
            phoneTxt?.text = String(phone)
        }
    }

}
