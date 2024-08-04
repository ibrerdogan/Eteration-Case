//
//  FavouriteViewController.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 2.08.2024.
//

import UIKit

class FavouriteViewController: UIViewController {
    var viewModel: FavouriteViewModel
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
    
    init(viewModel: FavouriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.updateView = {[weak self] in
            guard let strongSelf = self else {return}
            strongSelf.productCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar(title: "Favourites", hideBackButton: true)
        addComponents()
        configureLayout()
    }
    
    private func addComponents(){
        view.addSubview(productCollectionView)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            productCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            productCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
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


extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favouriteProductList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCustomCellView.identifier, for: indexPath) as? ProductCustomCellView else {return UICollectionViewCell()}
        cell.configureCellView(with: viewModel.favouriteProductList[indexPath.row])
        cell.addItemToFav = {[weak self] model in
            guard let strongSelf = self else {return}
            strongSelf.viewModel.addFavItem(model: model)
        }
        cell.addItemToCard = {[weak self] model in
            guard let strongSelf = self else {return}
            strongSelf.viewModel.addCardItem(model: model)
        }
        return cell
    }
    
    
}
