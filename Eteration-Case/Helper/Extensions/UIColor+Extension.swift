//
//  UIColor+Extension.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import UIKit

extension UIColor {
    static func convertHex(hex: String) -> UIColor? {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                            let scanner = Scanner(string: hexColor)
                            var hexNumber: UInt64 = 0

                            if scanner.scanHexInt64(&hexNumber) {
                                r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                                g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
                                b = CGFloat((hexNumber & 0x0000FF) >> 0) / 255

                                return UIColor(red: r, green: g, blue: b, alpha: 1)
                            
                            }
                }
        }
        return nil
    }

    
    static let mainBlueColor = UIColor.convertHex(hex: "#2A59FE")
    static let mainGrayColor = UIColor.convertHex(hex: "#D9D9D9")
    static let mainYellowColor = UIColor.convertHex(hex: "#FFB800")
}
