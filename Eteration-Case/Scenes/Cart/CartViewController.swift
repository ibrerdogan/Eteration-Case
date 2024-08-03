//
//  CartViewController.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 2.08.2024.
//

import UIKit

class CartViewController: UIViewController {
    var viewModel: CartViewModel
    private lazy var cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator =  false
        tableView.separatorStyle = .none
        return tableView
    }()
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
    
    private func addComponents()
    {
        view.addSubview(cartTableView)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
        
            cartTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        self.navigationItem.title = "Cart"
            
            // Hide the back button
            navigationItem.hidesBackButton = true
    }


}


extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cartTableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.cartProducts[indexPath.row])
        return cell
    }
    
    
}
