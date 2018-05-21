//
//  AddListingsViewController.swift
//  ListingLocation
//
//  Created by Apple on 14/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class AddListingsViewController: BaseViewController {
    
    // MARK:- Life Cycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigationBarDefaulyLayoutView()
        self.showIconBackOnNavigationBar()
        self.configureComponentLayout()
        self.showAddButtonOnNavigationBar()
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
    
    func showAddButtonOnNavigationBar(){
        let addBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: #selector(addBtnTapped))
        addBtn.title = "Add"
        addBtn.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    @objc func addBtnTapped(){
        let listingFormVcObj: ListingFormViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListingFormVc") as! ListingFormViewController
        listingFormVcObj.modalPresentationStyle = .overCurrentContext
        listingFormVcObj.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(listingFormVcObj, animated: true, completion: nil)
    }
    
    // MARK:- Common Methods
    
    func configureComponentLayout() {
        self.title = "Check In"
    }

}
