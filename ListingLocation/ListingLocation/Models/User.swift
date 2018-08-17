//
//  User.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//


import Foundation
import ObjectMapper

class User: Mappable {
    
    var email: String?
    var name: String?
    var phone: Int64?
    var id: Int64?
    var address_response: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var property_count: Int64?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        id <- map["id"]
        address_response <- map["address"]
        city <- map["city"]
        state <- map["state"]
        zipCode <- map["zipcode"]
        property_count <- map["property_count"]
    }
}

