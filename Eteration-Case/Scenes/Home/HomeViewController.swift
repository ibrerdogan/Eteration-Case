//
//  HomeViewController.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 2.08.2024.
//

import UIKit

class HomeViewController: UIViewController {
    var items = [ETProduct]()
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
    
    private lazy var filterContainerView: FilterContainerView = {
       let view = FilterContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var productCollectionView: UICollectionView = {
        let collectionView =  UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.register(ProductCustomCellView.self, forCellWithReuseIdentifier: ProductCustomCellView.identifier)
        return collectionView
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
                items = products
                productCollectionView.reloadData()
                print("\(products)")
            }
            catch{
                print("error")
            }
        }
    }
    
    
    private func addComponents(){
        view.addSubview(searchBar)
        view.addSubview(filterContainerView)
        view.addSubview(productCollectionView)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            filterContainerView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            filterContainerView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            filterContainerView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            
            productCollectionView.topAnchor.constraint(equalTo: filterContainerView.bottomAnchor, constant: 10),
            productCollectionView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            productCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func configureNavigationBar(){
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground() // This ensures the background color respects safe area
        appearance.backgroundColor = .mainBlueColor
            
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
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCustomCellView.identifier, for: indexPath) as? ProductCustomCellView else {return UICollectionViewCell()}
        cell.configureCellView(with: items[indexPath.row])
        return cell
    }
    
    
}
