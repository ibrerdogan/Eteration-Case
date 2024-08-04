//
//  ProductCustomCellView.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import Foundation
import UIKit
final class ProductCustomCellView: UICollectionViewCell{
    static let identifier = "ProductCustomCellView"
    var addItemToCard: (ETProduct) -> () = { _ in  }
    var addItemToFav: (ETProduct) -> () = { _ in  }
    var itemId: String = ""
    var product: ETProduct?
    private lazy var cellContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var producAddToFavouriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star.fill")?.withTintColor(.mainGrayColor!, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var producAddToChartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Chart", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tappedAddCard), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellView(with product: ETProduct){
        productNameLabel.text = product.name
        productPriceLabel.text = product.price
        itemId = product.id
        self.product = product
        configureFavButton()
        productImageView.setNetworkImage(urlStr: product.image)
    }
    
    
    private func addComponents(){
        cellContainerView.addSubview(productImageView)
        cellContainerView.addSubview(productPriceLabel)
        cellContainerView.addSubview(productNameLabel)
        cellContainerView.addSubview(producAddToChartButton)
        contentView.addSubview(cellContainerView)
        contentView.addSubview(producAddToFavouriteButton)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            
            cellContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            productImageView.topAnchor.constraint(equalTo: cellContainerView.topAnchor,constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: cellContainerView.leadingAnchor, constant: 10),
            productImageView.trailingAnchor.constraint(equalTo: cellContainerView.trailingAnchor, constant: -10),
            productImageView.heightAnchor.constraint(equalToConstant: 150),
            
            productPriceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            productPriceLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            productPriceLabel.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            
            productNameLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            
            producAddToChartButton.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            producAddToChartButton.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            producAddToChartButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            producAddToChartButton.heightAnchor.constraint(equalToConstant: 36),
            
            producAddToFavouriteButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 5),
            producAddToFavouriteButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -5),
            producAddToFavouriteButton.heightAnchor.constraint(equalToConstant: 24),
            producAddToFavouriteButton.widthAnchor.constraint(equalToConstant: 24),
            
            cellContainerView.bottomAnchor.constraint(equalTo: producAddToChartButton.bottomAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: cellContainerView.bottomAnchor)
        ])
    }
    
    func configureFavButton(){
        guard let product = product, let isFav = product.isFav else {return}
        let image = UIImage(systemName: "star.fill")?.withTintColor(isFav ? .mainYellowColor ?? .yellow : .mainGrayColor ?? .gray, renderingMode: .alwaysOriginal)
        producAddToFavouriteButton.setImage(image, for: .normal)
    }
    
    @objc func favouriteButtonTapped(){
        guard let product = product else {return}
        var manProduct = product
        toggleBoolValue(&manProduct.isFav)
        self.product = manProduct
        configureFavButton()
        addItemToFav(manProduct)
    }
    
    @objc func tappedAddCard(){
        guard let product = product else {return}
        addItemToCard(product)
    }
    
    func toggleBoolValue(_ value: inout Bool?) {
        if let currentValue = value {
            value = !currentValue
        } else {
            value = true
        }
    }
}
