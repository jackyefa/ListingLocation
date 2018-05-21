//
//  UIFont+Additions.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func normalFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func mediumFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }

    class func lightFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size)!
    }

    class func boldFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }

    class func italicFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Italic", size: size)!
    }
    
    class func thinFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Thin", size: size)!
    }
    
    class func ultraLightFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-UltraLight", size: size)!
    }
    
}

