//
//  LLButton.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

class LLButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        // set myValue before super.init is called
        super.init(coder: aDecoder)
        // set other operations after super.init, if required
    }
    
    func initializeButton_withRedTheme() {
        backgroundColor = UIColor.appRedButtonColor()
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont.normalFontOfSize(size: 16.0)
        layer.cornerRadius = 5
    }
    
}

