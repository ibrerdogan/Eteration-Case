//
//  MainTabbarViewModel.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 2.08.2024.
//

import UIKit
protocol TabBarDataSource {
    var viewControllers: [UIViewController] { get }
    var networkService: NetworkService {get set}
}

protocol TabBarEventSource: TabBarDataSource {
}

protocol TabBarViewProtocol: TabBarEventSource { }


final class MainTabbarViewModel: TabBarViewProtocol {
    var networkService: NetworkService
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    var viewControllers: [UIViewController] {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: UIImage(systemName: "house"),
                                                     selectedImage: UIImage(systemName: "house"))
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        
        let basketViewController = BasketViewController()
        basketViewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: UIImage(systemName: "cart"),
                                                     selectedImage: UIImage(systemName: "cart"))
        
        let favouriteViewcontroller = FavouriteViewController()
        favouriteViewcontroller.tabBarItem = UITabBarItem(title: nil,
                                                     image: UIImage(systemName: "star"),
                                                     selectedImage: UIImage(systemName: "star"))
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: UIImage(systemName: "person"),
                                                     selectedImage: UIImage(systemName: "person"))
        return [homeNavigationController,basketViewController,favouriteViewcontroller,profileViewController]
    }
}
