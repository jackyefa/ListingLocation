//
//  DashboardResponse.swift
//  ListingLocation
//
//  Created by Apple on 24/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import ObjectMapper

class DashboardResponse: Mappable {
    
    var userProperties: [Listings]?
    var allProperties: [Listings]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        userProperties <- map["user_properties"]
        allProperties <- map["all_properties"]
    }
}
