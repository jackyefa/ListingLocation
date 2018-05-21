//
//  ListingFormViewController.swift
//  ListingLocation
//
//  Created by Apple on 16/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class ListingFormViewController: BaseViewController {
    
    @IBOutlet var container_view: UIView?
    @IBOutlet var custom_header_view: UIView?
    @IBOutlet var proprtyAddressTxt: LLTextField?
    @IBOutlet var unitTxt: LLTextField?
    @IBOutlet var cityTxt: LLTextField?
    @IBOutlet var stateTxt: LLTextField?
    @IBOutlet var zipcodeTxt: LLTextField?
    @IBOutlet var sale_rent_txt: LLTextField?
    @IBOutlet var idNumberTxt: LLTextField?
    
    // MARK:- Life Cycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureComponentsLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    // MARK:- Common Methods
    
    func configureComponentsLayout(){
        self.container_view?.layer.cornerRadius = 8
        self.container_view?.clipsToBounds = true
        self.proprtyAddressTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.unitTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.cityTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.stateTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.zipcodeTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.sale_rent_txt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
        self.idNumberTxt?.initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: false)
    }
    
    // MARK:- Button tap actions.
    
    @IBAction func cancelBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }

}
