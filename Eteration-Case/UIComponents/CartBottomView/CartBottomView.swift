//
//  CartBottomView.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 4.08.2024.
//

import Foundation
import UIKit
final class CartBottomView: UIView {
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .montserratBold(size: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .montserratLight(size: 18)
        label.textColor = .mainBlueColor
        label.text = "Total"
        return label
    }()
    
    private lazy var completeButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .mainBlueColor
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Complete", for:  .normal)
        button.titleLabel?.font = .montserratSemiBold(size: 15)
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
    
    func setTotal(totalPrice: String){
        productPriceLabel.text = totalPrice
    }
    
    private func addComponents(){
        addSubview(productPriceLabel)
        addSubview(totalLabel)
        addSubview(completeButton)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
        
            completeButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            completeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            completeButton.heightAnchor.constraint(equalToConstant: 45),
            completeButton.widthAnchor.constraint(equalToConstant: 150),
            
            totalLabel.topAnchor.constraint(equalTo: completeButton.topAnchor, constant: 0),
            totalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            productPriceLabel.bottomAnchor.constraint(equalTo: completeButton.bottomAnchor, constant: 0),
            productPriceLabel.leadingAnchor.constraint(equalTo: totalLabel.leadingAnchor),
            
            bottomAnchor.constraint(equalTo: completeButton.bottomAnchor, constant: 10)
            
        ])
    }
    
    
}
