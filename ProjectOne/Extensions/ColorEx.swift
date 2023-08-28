//
//  ColorEx.swift
//  ProjectOne
//
//  Created by Timur Israilov on 27/09/21.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let hexString: String = (hex as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString as String)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF

        let red   = CGFloat(Int(color >> 16) & mask) / 255.0
        let green = CGFloat(Int(color >> 8) & mask) / 255.0
        let blue  = CGFloat(Int(color) & mask) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
