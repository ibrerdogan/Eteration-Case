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
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        productImageView.setNetworkImage(urlStr: viewModel.selectedProduct.image)
        productNameLabel.text = viewModel.selectedProduct.name
        productDescriptionLabel.text = viewModel.selectedProduct.description
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        addComponents()
        configureLayout()
    }
    
    
    private func addComponents(){
        view.addSubview(productImageView)
        view.addSubview(productNameLabel)
        view.addSubview(productDescriptionLabel)
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
            productDescriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
        self.navigationItem.title = viewModel.selectedProduct.name
            
            // Hide the back button
            navigationItem.hidesBackButton = false
    }

}
