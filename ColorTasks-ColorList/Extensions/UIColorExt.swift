//
//  Extensions.swift
//  ColorTasks-ColorList
//
//  Created by mac on 14/01/2024.
//

import UIKit

extension UIColor {
    
    static var veryLightGray: UIColor {
        return UIColor(hex: "ededed") ?? .lightGray
    }
    
    func toHexString() -> String {
            var r:CGFloat = 0
            var g:CGFloat = 0
            var b:CGFloat = 0
            var a:CGFloat = 0

            getRed(&r, green: &g, blue: &b, alpha: &a)

            let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
            return NSString(format:"#%06x", rgb) as String
    }
    // hex to UIColor initializer
    convenience init?(hex: String) {
            let r, g, b: CGFloat
            let start = hex.hasPrefix("#") ? hex.index(hex.startIndex, offsetBy: 1) : hex.startIndex
            let hexColor = String(hex[start...])

            guard hexColor.count == 6 else { return nil }

            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat(hexNumber & 0x0000ff) / 255

                self.init(red: r, green: g, blue: b, alpha: 1.0)
            } else {
                return nil
            }
        }
}
