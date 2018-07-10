//
//  AppDefaults.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

// MARK: - Default Persistant Storage

var property_id_default = UserDefaults.standard

var auth_token: String {
    get {
        var token: String = String()
        if(UserDefaults.standard.object(forKey: "auth_token") != nil) {
            token = UserDefaults.standard.object(forKey: "auth_token") as! String
        }
        return token
    }
    set (newValue) {
        UserDefaults.standard.set(newValue, forKey: "auth_token")
        UserDefaults.standard.synchronize()
    }
}

var remember_email: String {
    get{
        var email: String = String()
        if (UserDefaults.standard.object(forKey: "user_email") != nil){
            email = UserDefaults.standard.object(forKey: "user_email") as! String
        }
        return email
    }
    set(newValue){
        UserDefaults.standard.set(newValue, forKey: "user_email")
        UserDefaults.standard.synchronize()
    }
}

var user_email: String {
    get{
        var email: String = String()
        if (UserDefaults.standard.object(forKey: "email") != nil){
            email = UserDefaults.standard.object(forKey: "email") as! String
        }
        return email
    }
    set(newValue){
        UserDefaults.standard.set(newValue, forKey: "email")
        UserDefaults.standard.synchronize()
    }
}

var name: String {
    get{
        var name: String = String()
        if (UserDefaults.standard.object(forKey: "user_name") != nil){
            name = UserDefaults.standard.object(forKey: "user_name") as! String
        }
        return name
    }
    set(newValue){
        UserDefaults.standard.set(newValue, forKey: "user_name")
        UserDefaults.standard.synchronize()
    }
}

var address: String {
    get{
        var address: String = String()
        if (UserDefaults.standard.object(forKey: "user_address") != nil){
            address = UserDefaults.standard.object(forKey: "user_address") as! String
        }
        return address
    }
    set(newValue){
        UserDefaults.standard.set(newValue, forKey: "user_address")
        UserDefaults.standard.synchronize()
    }
}

var phone: Int64{
    get{
        var phone: Int64 = Int64()
        if ((UserDefaults.standard.object(forKey: "phone_number")) != nil){
            phone = UserDefaults.standard.object(forKey: "phone_number") as! Int64
        }
        return phone
    }
    set(newValue){
        UserDefaults.standard.set(newValue, forKey: "phone_number")
        UserDefaults.standard.synchronize()
    }
}

var id: Int64{
    get{
        var id: Int64 = Int64()
        if ((UserDefaults.standard.object(forKey: "user_id")) != nil){
            id = UserDefaults.standard.object(forKey: "user_id") as! Int64
        }
        return id
    }
    set(newValue){
        UserDefaults.standard.set(newValue, forKey: "user_id")
        UserDefaults.standard.synchronize()
    }
}

var property_images: NSMutableArray{
    get{
        var propertyImage: NSMutableArray = NSMutableArray()
        if ((UserDefaults.standard.object(forKey: "property_image")) != nil){
            propertyImage = UserDefaults.standard.object(forKey: "property_image") as! NSMutableArray
        }
        return propertyImage
    }
    set(newValue){
        UserDefaults.standard.set(newValue, forKey: "property_image")
        UserDefaults.standard.synchronize()
    }
}
