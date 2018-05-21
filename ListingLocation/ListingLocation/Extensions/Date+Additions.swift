//
//  Date+Additions.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    func getDayOfWeek(today:String)->String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let todayDate = formatter.date(from: today) {
            formatter.dateStyle = DateFormatter.Style.full
            let strFormatedDate = formatter.string(from: todayDate)
            return strFormatedDate
        } else {
            return ""
        }
    }
    
    public func getCurrentDate()-> String {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: date as Date) as String
        return currentDate
    }
    
    public func getFormattedDate()-> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "dd-MMM-yyyy"
        let currentDate = formatter.string(from: self as Date) as String
        return currentDate
    }
    
    public func getdDateForFilterPageApis()-> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: self as Date) as String
        return currentDate
    }
    
    func getDateForByIssueHeader(strDate: String)->String? {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let formatter_1 = DateFormatter()
        formatter_1.dateStyle = .short
        formatter_1.dateFormat = "dd MMMM yyyy"
        
        if let todayDate = formatter.date(from: strDate) {
            let choosenDate = formatter_1.string(from: todayDate) as String
            return choosenDate
        }else {
            let currentDate = formatter_1.string(from: self as Date) as String
            return currentDate
        }
    }
    
    func getDateForNotes(strDate: String)->String? {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let formatter_1 = DateFormatter()
        formatter_1.dateStyle = .short
        formatter_1.dateFormat = "dd MMM, yyyy"
        
        if let todayDate = formatter.date(from: strDate) {
            let choosenDate = formatter_1.string(from: todayDate) as String
            return choosenDate
        }else {
            let currentDate = formatter_1.string(from: self as Date) as String
            return currentDate
        }
    }
    
    // MARK:- Profile date format methods
    
    func getDefaultProfileFormatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: self) as String
        return currentDate
    }
    
}
