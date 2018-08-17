//
//  LLLabel.swift
//  ListingLocation
//
//  Created by Apple on 17/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

class LLLabel: UILabel{
    
    required init?(coder aDecoder: NSCoder) {
        // set myValue before super.init is called
        super.init(coder: aDecoder)
        // set other operations after super.init, if required
    }
    
    func initiliseLabelWithRedBoreder(){
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.appRedButtonColor().cgColor
    }
}
