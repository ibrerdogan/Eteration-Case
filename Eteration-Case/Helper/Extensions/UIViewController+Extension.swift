//
//  UIViewController+Extension.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 4.08.2024.
//

import Foundation
import UIKit
extension UIViewController{
    func overrideBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func configureNavigationBar(title: String, hideBackButton: Bool){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .mainBlueColor
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
       
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.isTranslucent = false // Optional: make the bar non-translucent
        
        self.navigationItem.title = title
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.hidesBackButton = hideBackButton
    }

}
