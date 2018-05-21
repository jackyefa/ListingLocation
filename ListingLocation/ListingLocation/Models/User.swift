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
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        id <- map["id"]
        
    }
}

