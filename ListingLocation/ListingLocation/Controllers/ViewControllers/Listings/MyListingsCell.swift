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
    
    @IBOutlet var proprtyCount: LLLabel?
    @IBOutlet var proprtyAddress: LLLabel?
    @IBOutlet var propertyUnit: LLLabel?
    @IBOutlet var propertyCity: LLLabel?
    @IBOutlet var propertyState: LLLabel?
    @IBOutlet var propertyZipcode: LLLabel?
    @IBOutlet var propertyImage: UIImageView?
    @IBOutlet var sale_rent_status: LLLabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.proprtyCount?.initiliseLabelWithRedBoreder()
        self.proprtyAddress?.initiliseLabelWithRedBoreder()
        self.propertyUnit?.initiliseLabelWithRedBoreder()
        self.propertyCity?.initiliseLabelWithRedBoreder()
        self.propertyState?.initiliseLabelWithRedBoreder()
        self.propertyZipcode?.initiliseLabelWithRedBoreder()
        self.sale_rent_status?.initiliseLabelWithRedBoreder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func assignDataToCell(userProperty: Listings, property_number: Int64){
        
        if let property_address = userProperty.property_address{
            self.proprtyAddress?.text = property_address
        }
        if let property_state = userProperty.property_state{
            self.propertyState?.text = property_state
        }
        if let property_city = userProperty.property_city{
            self.propertyCity?.text = property_city
        }
        if let property_type = userProperty.property_type?.capitalized{
            self.sale_rent_status?.text = property_type
        }
        if let imageUrl: String = userProperty.property_image, !imageUrl.isEmpty {
            self.propertyImage?.sd_setImage(with: NSURL(string: "https://" + imageUrl)! as URL, placeholderImage: UIImage(named: "annot_pin_big"), completed: nil)
        }
        if let property_unit = userProperty.unit{
            self.propertyUnit?.text = String(property_unit)
        }else{
            self.propertyUnit?.text = "0"
        }
        if let property_zipcode = userProperty.property_zipcode{
            self.propertyZipcode?.text = property_zipcode
        }
        self.proprtyCount?.text = String(property_number)
     }

}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

