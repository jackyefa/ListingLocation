//
//  PropertyCollectionViewCell.swift
//  ListingLocation
//
//  Created by Apple on 22/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

protocol PropertyCollectionViewCellDelegate {
    func deleteProperty()
}

class PropertyCollectionViewCell: UICollectionViewCell {
    
    var propertyDelegate: PropertyCollectionViewCellDelegate?
    
    func configureComponentsLayout(){
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 6
    }
    
    @IBAction func deleteBtnTapped(_ sender: UIButton){
        propertyDelegate?.deleteProperty()
    }
}
