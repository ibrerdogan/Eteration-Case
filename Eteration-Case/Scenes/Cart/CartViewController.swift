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
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .montserratSemiBold(size: 18)
        label.textColor = .mainBlueColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Sepette hiç ürününüz yok"
        return label
    }()
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.updateView = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.configureView(isNoProduct: strongSelf.viewModel.cartProducts.count == 0)
            strongSelf.cartTableView.reloadData()
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView(isNoProduct: false)
        configureNavigationBar(title: "Cart", hideBackButton: true)
        addComponents()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView(isNoProduct: viewModel.cartProducts.count == 0)
    }
    private func addComponents()
    {
        view.addSubview(cartTableView)
        view.addSubview(infoLabel)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
        
            cartTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func configureView(isNoProduct: Bool){
        cartTableView.isHidden = isNoProduct
        infoLabel.isHidden = !isNoProduct
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
        cell.selectionStyle = .none
        cell.productQuantityChanged = {[weak self] model in
            guard let strongSelf = self else {return}
            strongSelf.viewModel.updateCartWithModel(with: model)
            
        }
        return cell
    }
    
    
}
