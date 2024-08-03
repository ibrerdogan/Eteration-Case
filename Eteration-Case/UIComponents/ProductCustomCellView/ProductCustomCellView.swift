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
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var producAddToChartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Chart", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
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
        productImageView.setNetworkImage(urlStr: product.image)
    }
    
    
    private func addComponents(){
        contentView.addSubview(productImageView)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(producAddToFavouriteButton)
        contentView.addSubview(producAddToChartButton)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
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
            
            contentView.bottomAnchor.constraint(equalTo: producAddToChartButton.bottomAnchor, constant: 10)
        ])
    }
    
    @objc func favouriteButtonTapped(){
        print("tapped fav")
    }
}
