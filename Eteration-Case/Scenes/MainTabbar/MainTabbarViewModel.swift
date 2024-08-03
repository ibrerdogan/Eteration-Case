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
    var coreDataManager: CoreDataManager {get set}
}

protocol TabBarEventSource: TabBarDataSource {
}

protocol TabBarViewProtocol: TabBarEventSource { }


final class MainTabbarViewModel: TabBarViewProtocol {
    var coreDataManager: CoreDataManager
    var networkService: NetworkService
    
    init(networkService: NetworkService,coreDataManager: CoreDataManager) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
    }
    var viewControllers: [UIViewController] {
        let homeViewModel = HomeViewModel(networkService: networkService,coreDataManager: coreDataManager)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        homeViewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: UIImage(systemName: "house"),
                                                     selectedImage: UIImage(systemName: "house"))
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        
        let cartViewModel = CartViewModel(coreDataManager: coreDataManager)
        let cartViewController = CartViewController(viewModel: cartViewModel)
        cartViewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: UIImage(systemName: "cart"),
                                                     selectedImage: UIImage(systemName: "cart"))
        let cartNavigationController = UINavigationController(rootViewController: cartViewController)
        
        let favouriteViewcontroller = FavouriteViewController()
        favouriteViewcontroller.tabBarItem = UITabBarItem(title: nil,
                                                     image: UIImage(systemName: "star"),
                                                     selectedImage: UIImage(systemName: "star"))
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: UIImage(systemName: "person"),
                                                     selectedImage: UIImage(systemName: "person"))
        return [homeNavigationController,cartNavigationController,favouriteViewcontroller,profileViewController]
    }
}
