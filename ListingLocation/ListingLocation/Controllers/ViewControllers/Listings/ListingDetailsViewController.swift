//
//  ListingDetailsViewController.swift
//  ListingLocation
//
//  Created by Apple on 22/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class ListingDetailsViewController: BaseViewController {
    
    // MARK:- Life Cycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigationBarDefaulyLayoutView()
        self.showIconBackOnNavigationBar()
        self.configureComponentsLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        self.title = "Listing Details"
    }
}
