//
//  UIColor.swift
//  
//
//  Created by Henrique Semmer on 19/02/24.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func background() -> UIColor {
        return UIColor.rgb(red: 66, green: 47, blue: 47)
    }
    
    static func wood() -> UIColor {
        return UIColor.rgb(red: 232, green: 185, blue: 129)
    }
    
    static func star() -> UIColor {
        return UIColor.rgb(red: 255, green: 240, blue: 105)
    }
    
    static func starDark() -> UIColor {
        return UIColor.rgb(red: 113, green: 68, blue: 0)
    }
}
