//
//  CartBottomView.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 4.08.2024.
//

import Foundation
import UIKit
final class CartBottomView: UIView {
    var buttonTapped: ()->() = { }
    var viewType: BottomViewType
    private lazy var fieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
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
        button.titleLabel?.font = .montserratSemiBold(size: 20)
        button.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(type: BottomViewType) {
        self.viewType = type
        super.init(frame: .zero)
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
        switch viewType {
        case .cart:
            fieldStackView.addArrangedSubview(productPriceLabel)
            fieldStackView.addArrangedSubview(totalLabel)
            totalLabel.text = "Total"
            completeButton.setTitle("Complete", for:  .normal)
        case .detail:
            totalLabel.text = "Price"
            completeButton.setTitle("Add to Cart", for:  .normal)
            fieldStackView.addArrangedSubview(totalLabel)
            fieldStackView.addArrangedSubview(productPriceLabel)
        }
        addSubview(fieldStackView)
        addSubview(completeButton)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
        
            completeButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            completeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            completeButton.heightAnchor.constraint(equalToConstant: 45),
            completeButton.widthAnchor.constraint(equalToConstant: 150),
            
            fieldStackView.topAnchor.constraint(equalTo: completeButton.topAnchor),
            fieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            fieldStackView.bottomAnchor.constraint(equalTo: completeButton.bottomAnchor),
            
            
            bottomAnchor.constraint(equalTo: completeButton.bottomAnchor, constant: 10)
            
        ])
    }
    
    @objc func mainButtonTapped(){
        buttonTapped()
    }

    
}

enum BottomViewType{
    case cart
    case detail
}
