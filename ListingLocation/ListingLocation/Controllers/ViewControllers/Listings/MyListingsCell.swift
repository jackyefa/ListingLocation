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

protocol MyListingsCellDelegate{
    func downloadBtnAction(listingID: Int64)
}

class MyListingsCell: UITableViewCell {
    
    @IBOutlet var propertyImage: UIImageView?
    @IBOutlet var proprtyAddress: UILabel?
    @IBOutlet var propertyState: UILabel?
    @IBOutlet var propertyCity: UILabel?
    @IBOutlet var sale_rent_status: UILabel?
    var alertListingLocation: UIAlertController?
    @IBOutlet var downloadBtn: UIButton?
    var myListingsDelegate: MyListingsCellDelegate?
    var listing_id: Int64?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func assignDataToCell(userProperty: Listings){
        
        let arrayOfIds = property_id_default.object(forKey: "property_id")
        if (arrayOfIds != nil){
            for property_id in arrayOfIds as! [Int64] {
                if(property_id == userProperty.id_number){
                    self.downloadBtn?.isHidden = true
                }
            }
        }
        
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
        if let listingID = userProperty.id_number{
            self.listing_id = listingID
        }
        
        if let imageUrl: String = userProperty.property_image, !imageUrl.isEmpty {
            self.propertyImage?.sd_setImage(with: NSURL(string: "https://" + imageUrl)! as URL, placeholderImage: UIImage(named: "pin"), completed: nil)
        }
     }
    
    @IBAction func downloadBtnTapped(_ sender: UIButton){
        if let image = self.propertyImage?.image {
            UIImageWriteToSavedPhotosAlbum((image), self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        self.myListingsDelegate?.downloadBtnAction(listingID: self.listing_id!)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: error.localizedDescription)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertListingLocation!, animated: true, completion: nil)

        } else {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: "My Listing Location", message: "The image had been stored in your pictures.")
            UIApplication.shared.keyWindow?.rootViewController?.present(alertListingLocation!, animated: true, completion: nil)
            self.downloadBtn?.isHidden = true
        }
    }

}

