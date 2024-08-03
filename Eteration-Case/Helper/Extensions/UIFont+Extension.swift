//
//  UIFont+Extension.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import UIKit

extension UIFont {
    @objc class func montserratMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Manrope-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    @objc class func montserratBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Manrope-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    @objc class func montserratRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Manrope-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    @objc class func montserratSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Manrope-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    @objc class func montserratLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Manrope-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
