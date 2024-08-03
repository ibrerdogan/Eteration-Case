//
//  CartTableViewCell.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import UIKit
final class CartTableViewCell: UITableViewCell {
    static let identifier = "CartTableViewCell"
    private lazy var cellContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "Samsung"
        return label
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "100.0"
        return label
    }()
    
    private lazy var decreaseCartQuantityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .mainGrayColor
        button.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        return button
    }()
    
    private lazy var increaseCartQuantityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .mainGrayColor
        button.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        return button
    }()
    
    private lazy var quantityDisplayingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.backgroundColor = .mainBlueColor
        label.textColor = .white
        label.font = .montserratRegular(size: 18)
        label.text = "10"
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponents()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents(){
        cellContainerView.addSubview(productPriceLabel)
        cellContainerView.addSubview(productNameLabel)
        cellContainerView.addSubview(decreaseCartQuantityButton)
        cellContainerView.addSubview(increaseCartQuantityButton)
        cellContainerView.addSubview(quantityDisplayingLabel)
        contentView.addSubview(cellContainerView)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            cellContainerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            cellContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            cellContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            quantityDisplayingLabel.topAnchor.constraint(equalTo: cellContainerView.topAnchor),
            quantityDisplayingLabel.trailingAnchor.constraint(equalTo: increaseCartQuantityButton.leadingAnchor),
            quantityDisplayingLabel.heightAnchor.constraint(equalToConstant: 50),
            quantityDisplayingLabel.widthAnchor.constraint(equalToConstant: 55),
            
            increaseCartQuantityButton.trailingAnchor.constraint(equalTo: cellContainerView.trailingAnchor),
            increaseCartQuantityButton.centerYAnchor.constraint(equalTo: quantityDisplayingLabel.centerYAnchor),
            increaseCartQuantityButton.heightAnchor.constraint(equalToConstant: 45),
            increaseCartQuantityButton.widthAnchor.constraint(equalToConstant: 50),
            
            
            decreaseCartQuantityButton.trailingAnchor.constraint(equalTo: quantityDisplayingLabel.leadingAnchor),
            decreaseCartQuantityButton.centerYAnchor.constraint(equalTo: quantityDisplayingLabel.centerYAnchor),
            decreaseCartQuantityButton.heightAnchor.constraint(equalToConstant: 45),
            decreaseCartQuantityButton.widthAnchor.constraint(equalToConstant: 50),
            
            productNameLabel.topAnchor.constraint(equalTo: increaseCartQuantityButton.topAnchor),
            productNameLabel.leadingAnchor.constraint(equalTo: cellContainerView.leadingAnchor),
            
            productPriceLabel.bottomAnchor.constraint(equalTo: increaseCartQuantityButton.bottomAnchor),
            productPriceLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            
            cellContainerView.bottomAnchor.constraint(equalTo: quantityDisplayingLabel.bottomAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: cellContainerView.bottomAnchor,constant: 10)
            
        ])
    }
    
    @objc func increaseQuantity(){
        print("increaseQuantity")
    }
    
    @objc func decreaseQuantity(){
        print("decreaseQuantity")
    }
}
