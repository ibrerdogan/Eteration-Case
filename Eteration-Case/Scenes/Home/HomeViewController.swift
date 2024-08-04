//
//  HomeViewController.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 2.08.2024.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModel
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search",
                                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.mainBlueColor?.withAlphaComponent(0.3) ?? .gray,
                                                                                          NSAttributedString.Key.font: UIFont.montserratMedium(size: 18)])
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var filterContainerView: FilterContainerView = {
       let view = FilterContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.openFilter = { [weak self] in
            guard let strongSelf = self else  {return}
            let filterViewModel = FilterViewModel(productItemList: strongSelf.viewModel.staticProductItemList)
            let viewController = FilterViewController(viewModel: filterViewModel)
            strongSelf.present(viewController, animated: true)
        }
        return view
    }()
    
    private lazy var productCollectionView: UICollectionView = {
        let collectionView =  UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCustomCellView.self, forCellWithReuseIdentifier: ProductCustomCellView.identifier)
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        return indicator
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setIndicatorViewvisibilty(isVisible: true)
        configureNavigationBar()
        addComponents()
        configureLayout()
        viewModel.updateView = { [weak self] in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
                strongSelf.setIndicatorViewvisibilty(isVisible: false)
                strongSelf.productCollectionView.reloadData()
            }
        }
    }
    
    
    private func addComponents(){
        view.addSubview(searchBar)
        view.addSubview(filterContainerView)
        view.addSubview(productCollectionView)
        view.addSubview(activityIndicator)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            filterContainerView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            filterContainerView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 10),
            filterContainerView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -10),
            
            productCollectionView.topAnchor.constraint(equalTo: filterContainerView.bottomAnchor, constant: 10),
            productCollectionView.leadingAnchor.constraint(equalTo: filterContainerView.leadingAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: filterContainerView.trailingAnchor),
            productCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    private func pushDetailView(with model: ETProduct){
        let viewModel = DetailViewModel(selectedProduct: model)
        let viewController = DetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    private func setIndicatorViewvisibilty(isVisible: Bool){
        activityIndicator.isHidden = !isVisible
        isVisible ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        view.addSubview(searchBar)
        [searchBar,filterContainerView,productCollectionView].forEach { [weak self] view in
            guard let strongSelf = self else {return}
            view.isHidden = isVisible
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCustomCellView.identifier, for: indexPath) as? ProductCustomCellView else {return UICollectionViewCell()}
        var model = viewModel.productItemList[indexPath.row]
        model.isFav = viewModel.productIsAddedFav(with: model.id)
        cell.configureCellView(with: model)
        cell.addItemToCard = {[weak self] model in
            guard let strongSelf = self else {return}
            strongSelf.viewModel.addCardItem(model: model)
        }
        cell.addItemToFav = {[weak self] model in
            guard let strongSelf = self else {return}
            strongSelf.viewModel.addFavItem(model: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushDetailView(with: viewModel.productItemList[indexPath.row])
    }
}

extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        viewModel.searchProduct(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        viewModel.searchProduct(with: "")
    }

}
