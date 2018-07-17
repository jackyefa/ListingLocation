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
    @IBOutlet var propertyState: UILabel?
    @IBOutlet var propertyCity: UILabel?
    @IBOutlet var sale_rent_status: UILabel?
    var alertListingLocation: UIAlertController?

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
        if let property_state = userProperty.property_state{
            self.propertyState?.text = property_state
        }
        if let property_city = userProperty.property_city{
            self.propertyCity?.text = property_city
        }
        if let property_type = userProperty.property_type{
            if (property_type == "sale"){
                self.sale_rent_status?.text = "Sale"
                self.sale_rent_status?.textColor = UIColor.appRedButtonColor()
            }else{
                self.sale_rent_status?.text = "Rent"
                self.sale_rent_status?.textColor = UIColor.appBlueThemeColor()
            }
        }
        if let imageUrl: String = userProperty.property_image, !imageUrl.isEmpty {
            self.propertyImage?.sd_setImage(with: NSURL(string: "https://" + imageUrl)! as URL, placeholderImage: UIImage(named: "pin"), completed: nil)
        }
     }

}

