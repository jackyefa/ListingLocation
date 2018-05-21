//
//  String+Additions.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // MARK: To check Email is valid or not
    func isValidEmailAddress() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    // MARK: To check Phone umber is valid or not
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let phoneRegex = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result =  phoneTest.evaluate(with: phoneNumber)
        return result
    }
    
    func getDate(strDate:NSString) -> NSString {
        print(strDate.length)
        let substring1 = strDate.substring(with: NSMakeRange(0,6))
        return substring1 as NSString
    }
    
    func isWhatPercentOf(total: String) -> Float {
        let allQuestions: Int = Int(total)!
        let correctAnswers: Int = allQuestions - Int(self)!
        return Float((100 * correctAnswers)/allQuestions)
    }

    // MARK:- Profile date format methods
    
    func getDateForProfileDependent() -> String {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateStyle = .short
        guard let todayDate = dateFormatter.date(from: self) else {
            return self
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: todayDate) as String
        return currentDate
    }
    
    func getDateForProfileContactAddress() -> String {
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let todayDate = dateFormatter.date(from: self) else {
            return self
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: todayDate) as String
        return currentDate
    }
}
