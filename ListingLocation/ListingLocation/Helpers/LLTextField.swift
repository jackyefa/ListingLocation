//
//  LLTextField.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

class LLTextField : UITextField {
    
    func initialize_customTextField(withSecuredEntery: Bool) {
        let vwImage = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 5))
        self.leftView = vwImage
        self.returnKeyType = UIReturnKeyType.done
        self.leftViewMode = UITextFieldViewMode.always
        self.backgroundColor = UIColor.clear
        self.borderStyle = .none
        self.font = UIFont.normalFontOfSize(size: 15.0)
        self.textColor = UIColor.black
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        if withSecuredEntery {
            self.isSecureTextEntry = true
        }
    }
    
    func initiliase_customTextField_with_blue_background(){
        let vwImage = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 5))
        self.leftView = vwImage
        self.returnKeyType = UIReturnKeyType.done
        self.leftViewMode = UITextFieldViewMode.always
        self.backgroundColor = UIColor.appBlueThemeColor()
        self.borderStyle = .none
        self.font = UIFont.normalFontOfSize(size: 15.0)
        self.textColor = UIColor.white
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        self.layer.borderColor = UIColor.appRedButtonColor().cgColor
        self.layer.borderWidth = 1.5
    }
    
    func initialize_customTextFieldWith_letfImage(_ imageName: String, withSecuredEntery: Bool) {
        if !imageName.isEmpty {
            let imageView = UIImageView(image: UIImage(named:imageName))
            imageView.frame = CGRect(x: 10, y: 7, width: 20, height: 20)
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            let rightImage = UIView(frame:CGRect(x: 0, y: 0, width: 40, height: 35))
            rightImage.addSubview(imageView)
            self.rightView = rightImage
            self.rightViewMode = .always
            let leftImage = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 5))
            self.leftView = leftImage
            self.leftViewMode = UITextFieldViewMode.always
            self.returnKeyType = UIReturnKeyType.done
            self.backgroundColor = UIColor.clear
            self.borderStyle = .none
            self.font = UIFont.normalFontOfSize(size: 15.0)
            self.textColor = UIColor.black
            self.clearButtonMode = UITextFieldViewMode.whileEditing
            self.layer.masksToBounds = false
            if withSecuredEntery {
                self.isSecureTextEntry = true
            }
        }
    }
    
    func setupCustomTextFieldWith_ImageName(_ imageName: String, withSecuredEntery: Bool) {
        if !imageName.isEmpty {
            let image = UIImage(named:imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 15, y: 9.5, width: 25, height: 25)
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            let vwImage = UIView(frame:CGRect(x: 0, y: 0, width: 55, height: 44))
            vwImage.addSubview(imageView)
            self.leftView = vwImage
            self.returnKeyType = UIReturnKeyType.done
            self.leftViewMode = UITextFieldViewMode.always
            self.backgroundColor = UIColor.clear
            self.borderStyle = .none
            self.font = UIFont.normalFontOfSize(size: 15.0)
            self.textColor = UIColor.white
            self.clearButtonMode = UITextFieldViewMode.whileEditing
            self.layer.masksToBounds = true
            let border = CALayer()
            let width = CGFloat(1.0)
            border.borderColor = UIColor.textFieldBorderColor().cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
            border.borderWidth = width
            self.layer.addSublayer(border)
            if withSecuredEntery {
                self.isSecureTextEntry = true
            }
        }else{
            self.returnKeyType = UIReturnKeyType.done
            self.backgroundColor = UIColor.clear
            self.borderStyle = .none
            self.font = UIFont.normalFontOfSize(size: 15.0)
            self.textColor = UIColor.black
            self.clearButtonMode = UITextFieldViewMode.never
            self.layer.masksToBounds = true
            let border = CALayer()
            let width = CGFloat(1.0)
            border.borderColor = UIColor.textFieldBorderColor().cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
            border.borderWidth = width
            self.layer.addSublayer(border)
            if withSecuredEntery {
                self.isSecureTextEntry = true
            }
        }
        
    }
    
    func initializeCustomTextFieldWith_BottomLineView(withSecuredEntery: Bool) {
        self.returnKeyType = UIReturnKeyType.done
        self.backgroundColor = UIColor.white
        self.borderStyle = .none
        self.font = UIFont.normalFontOfSize(size: 15)
        self.textColor = UIColor.black
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.textFieldBorderColor().cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0.0
        if withSecuredEntery {
            self.isSecureTextEntry = true
        }
    }
}

