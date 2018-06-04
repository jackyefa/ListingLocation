//
//  Listings.swift
//  ListingLocation
//
//  Created by Apple on 24/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import ObjectMapper

class Listings: Mappable {
    
    var property_address: String?
    var unit: Int64?
    var property_city: String?
    var property_state: String?
    var property_zipcode: Int64?
    var property_type: String?
    var id_number: Int64?
    var latitude: Double?
    var longitude: Double?
    var property_image: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        unit <- map["unit"]
        property_address <- map["address"]
        property_city <- map["city"]
        property_state <- map["state"]
        property_zipcode <- map["zipcode"]
        property_type <- map["property_type"]
        id_number <- map["id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        property_image <- map["image"]
    }
}
