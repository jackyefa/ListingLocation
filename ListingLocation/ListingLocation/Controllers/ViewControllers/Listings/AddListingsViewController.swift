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
    
    @IBOutlet var propertyCollection: UICollectionView?
    var allProperties: [Listings]?
    var userProperties: [Listings]?
    
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

// MARK: - CollectionView delegate and data source methods.

extension AddListingsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return (userProperties?.count)!
        }else{
            return (allProperties?.count)!
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview: UICollectionReusableView? = nil
        if kind == UICollectionElementKindSectionHeader{
            let headerView = propertyCollection?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! HeaderReusableView
            
            if indexPath.section == 0{
                headerView.headerLbl?.text = "User Properties"
            }else{
                headerView.headerLbl?.text = "All Properties"
            }
            reusableview = headerView
        }
        return reusableview!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let propertyColllectionCell = propertyCollection?.dequeueReusableCell(withReuseIdentifier: "propertyCollectionView", for: indexPath) as! PropertyCollectionViewCell
        propertyColllectionCell.configureComponentsLayout()
        propertyColllectionCell.propertyDelegate = self
        return propertyColllectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listingDetailsVcObj: ListingDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListingDetailsVc") as! ListingDetailsViewController
        self.navigationController?.pushViewController(listingDetailsVcObj, animated: true)
    }
}

// MARK: - Property cell delegate method.

extension AddListingsViewController: PropertyCollectionViewCellDelegate{
    
    func deleteProperty() {
        self.alertListingLocation = UIAlertController.confirmAlertWithTwoButtonTitles(title: appTitle, message: "Are you sure you want to delete this property?", btnTitle1:"Yes", btnTitle2: "No", handler:{(objAlertAction : UIAlertAction!) -> Void in
            
        })
        self.present(self.alertListingLocation!, animated:true, completion:nil)
    }
    
}

