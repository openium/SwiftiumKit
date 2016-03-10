//
//  UIColor+OSKAdditions.swift
//  OpeniumSwiftKit
//
//  Created by Richard Bergoin on 21/07/15.
//  Copyright (c) 2015 Openium. All rights reserved.
//

import UIKit

extension UIColor {

    /** Method to instanciate a color from an int (0xRRGGBB).
    
    Usage example :
    
    color = UIColor(rgb: 0xAABBCC)
    
    @param rgb an int which bytes represents red, green and blue components
    @return an UIColor instance
    */
    public convenience init(rgb: Int64) {
        let alpha = CGFloat(1.0)
        let red   = CGFloat((0xff0000   & rgb) >> 16) / 255.0
        let green = CGFloat((0xff00     & rgb) >>  8) / 255.0
        let blue  = CGFloat((0xff       & rgb)      ) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /** Method to instanciate a color from an int (0xRRGGBBAA).
     
     Usage example :
     
     color = UIColor(rgb: 0xAABBCCDD)
     
     @param rgba an int which bytes represents red, green blue and alpha components
     @return an UIColor instance
     */
    public convenience init(rgba: Int64) {
        let red   = CGFloat((0xff000000 & rgba) >> 24) / 255.0
        let green = CGFloat((0xff0000   & rgba) >> 16) / 255.0
        let blue  = CGFloat((0xff00     & rgba) >>  8) / 255.0
        let alpha = CGFloat((0xff       & rgba)      ) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /** Method to instanciate a color from an int (0xAARRGGBB).
     
     Usage example :
     
     color = UIColor(rgb: 0xAABBCCDD)
     
     @param argb an int which bytes represents alpha, red, green and blue components
     @return an UIColor instance
     */
    public convenience init(argb: Int64) {
        let alpha = CGFloat((0xff000000 & argb) >> 24) / 255.0
        let red   = CGFloat((0xff0000   & argb) >> 16) / 255.0
        let green = CGFloat((0xff00     & argb) >>  8) / 255.0
        let blue  = CGFloat((0xff       & argb)      ) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
