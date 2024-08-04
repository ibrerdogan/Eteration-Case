//
//  DetailViewController.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 4.08.2024.
//

import UIKit

final class DetailViewController: UIViewController{
    let viewModel: DetailViewModel
    
    private lazy var productImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = .montserratBold(size: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var productDescriptionLabel: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .black
        textView.font = .montserratRegular(size: 14)
        textView.isEditable = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.contentInset = .zero
        return textView
    }()
    
    private lazy var bottomView: CartBottomView = {
        let view = CartBottomView(type: .detail)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        productImageView.setNetworkImage(urlStr: viewModel.selectedProduct.image)
        productNameLabel.text = viewModel.selectedProduct.name
        productDescriptionLabel.text = viewModel.selectedProduct.description
        bottomView.setTotal(totalPrice: "\(viewModel.selectedProduct.price) ₺" )
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar(title: viewModel.selectedProduct.name, hideBackButton: false)
        addComponents()
        configureLayout()
    }
    
    
    private func addComponents(){
        view.addSubview(productImageView)
        view.addSubview(productNameLabel)
        view.addSubview(productDescriptionLabel)
        view.addSubview(bottomView)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
        
            productImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            productImageView.heightAnchor.constraint(equalToConstant: 250),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            productDescriptionLabel.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    

}
