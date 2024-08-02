//
//  HomeViewController.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 2.08.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Please provide the Project title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])

        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        addComponents()
        configureLayout()
        let network = NetworkService()
        Task{
            do {
                let products : [ETProduct] = try await network.request(endpoint: .getProducts)
                print("\(products)")
            }
            catch{
                print("error")
            }
        }
    }
    
    
    private func addComponents(){
        view.addSubview(searchBar)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureNavigationBar(){
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground() // This ensures the background color respects safe area
            appearance.backgroundColor = .blue
            
            // Apply the appearance to the navigation bar
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.isTranslucent = false // Optional: make the bar non-translucent
            
            // Set the navigation bar title
        self.navigationItem.title = "Home"
            
            // Hide the back button
            navigationItem.hidesBackButton = true
    }


}
