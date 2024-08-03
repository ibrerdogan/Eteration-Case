//
//  UIImageView+Extensions.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {
    func setNetworkImage(urlStr: String?) {
        guard let string = urlStr, let url = URL(string: string) else {
            self.image = UIImage(named: "largeAppIcon")
            return
        }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
            switch result{
            case .success(let img):
                self.image = img.image
            case .failure(_):
                self.image = UIImage(named: "largeAppIcon")
            }
        }
    }
}
