//
//  Constants.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Application Constants

let objWindow: UIWindow = UIApplication.shared.delegate!.window!!
let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
let emptyString: String = String()
let noDataText: String = "N/A"
let appTitle: String = "My Listing Location"
var property_id_Array:[Int64] = NSMutableArray() as! [Int64]

// MARK: - Application Notification Identifiers

let INVALID_USER_ACCESS_TOKEN_NOTIFICATION = Notification.Name("InvalidUserAccessToken")
let LOGOUT_USER_NOTIFICATION = Notification.Name("LogoutUser")
let UPDATE_USER_DETAILS_NOTIFICATION = Notification.Name("UpdateDetails")
let UPDATE_DASHBOARD_NOTIFICATION = Notification.Name("UpdateDashboard")

// MARK: - Common Error Objects

let NO_NETWORK_ERROR : NSError = NSError(domain: "ServiceUnavailable", code: 503, userInfo: [NSLocalizedDescriptionKey : "Sorry! There is no network connection found, please try again later."])

func getFailureError(_ response: NSDictionary) -> NSError {
    guard let strError: String = response["error"] as? String else {
        return NSError(domain: "HttpResponseErrorDomain", code: 404, userInfo:[NSLocalizedDescriptionKey: "UnKnown error"])
    }
    return NSError(domain: "HttpResponseErrorDomain", code: 404, userInfo:[NSLocalizedDescriptionKey: strError])
}


