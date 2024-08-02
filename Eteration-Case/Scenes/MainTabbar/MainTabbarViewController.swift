//
//  MainTabbarViewController.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 2.08.2024.
//

import UIKit

final class MainTabbarViewController: UITabBarController, UITabBarControllerDelegate {
    var viewModel: MainTabbarViewModel
    
    init(viewModel: MainTabbarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = viewModel.viewControllers
        delegate = self
        setTabBarAppearance()
    }
    
    private func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        let borderTop = CALayer()
        borderTop.backgroundColor = UIColor.white.cgColor
        borderTop.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1.0 / UIScreen.main.scale)
        tabBar.layer.addSublayer(borderTop)

        self.tabBar.standardAppearance = appearance
        tabBar.tintColor = .black
    }
}
