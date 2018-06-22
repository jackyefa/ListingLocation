//
//  MyListingsCell.swift
//  ListingLocation
//
//  Created by Apple on 22/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage

class MyListingsCell: UITableViewCell {
    
    @IBOutlet var propertyImage: UIImageView?
    @IBOutlet var proprtyAddress: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func assignDataToCell(userProperty: Listings){
        if let property_address = userProperty.property_address{
            self.proprtyAddress?.text = property_address
        }
        if let imageUrl: String = userProperty.property_image, !imageUrl.isEmpty {
            self.propertyImage?.sd_setImage(with: NSURL(string: imageUrl)! as URL, placeholderImage: UIImage(named: "property"), completed: nil)
        }
    }

}
