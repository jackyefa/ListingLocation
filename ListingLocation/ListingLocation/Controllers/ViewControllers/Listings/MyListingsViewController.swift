//
//  MyListingsViewController.swift
//  ListingLocation
//
//  Created by Apple on 22/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class MyListingsViewController: BaseViewController {
    
    @IBOutlet var listingsTblView: UITableView?
    var userProperties: [Listings]?
    
    // MARK:- Life Cycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureComponentsLayout()
        self.listings_Api_call()
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
    
    // MARK: - API_call_methods
    
    func listings_Api_call(){
        APIManager.sharedAPIManager.user_dashboard_apiCall( success: {(responseDictionary: DashboardResponse) -> () in
            self.userProperties = responseDictionary.userProperties
            self.listingsTblView?.reloadData()
            
        },failure: { (error: NSError) -> () in
            self.showPopupWith_title_message(strTitle: appTitle, strMessage: error.localizedDescription)
            self.userProperties = []
            self.listingsTblView?.reloadData()
        })
    }
    
    // MARK:- Common Methods
    
    func configureComponentsLayout(){
        self.title = "My Listings"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.showIconBackOnNavigationBar()
        self.listingsTblView?.tableFooterView = UIView()
    }

}

// MARK:- UITableView delegate and data source methods

extension MyListingsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((userProperties?.count) != nil){
            return (userProperties?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myListingsCell = tableView.dequeueReusableCell(withIdentifier: "myListings", for: indexPath) as! MyListingsCell
        myListingsCell.assignDataToCell(userProperty: userProperties![indexPath.row])
        myListingsCell.selectionStyle = .none
        return myListingsCell
    }
    
}

