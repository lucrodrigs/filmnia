//
//  UIColors.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 17/02/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex6 & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    //MARK: - String representation of the hexadecimal string: RRGGBB
    var hexString: String? {
        if let components = self.cgColor.components {
            if components.count == 2 {
                let white = components[0]
                return  String(format: "%02X%02X%02X", (Int)(white * 255), (Int)(white * 255), (Int)(white * 255))
            }
            if components.count >= 3 {
                let r = components[0]
                let g = components[1]
                let b = components[2]
                return  String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
            }
            return nil
        }
        return nil
    }
    
    //MARK: - String representation in the format #RRGGBB
    var photoshopString: String {
        return "#\(hexString ?? "000000")"
    }
    
    //MARK: - Colors
    public static let ColorDarkBlueDefault = UIColor(hex6: 0x050409)
    public static let ColorGrayDefault = UIColor(hex6: 0x4F4F4F)
    public static let ColorDarkDefault = UIColor(hex6: 0x19181d)
    
}
