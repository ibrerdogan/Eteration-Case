//
//  FilterViewController.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 4.08.2024.
//

import UIKit
final class FilterViewController: UIViewController {
    var viewModel: FilterViewModel
    private lazy var closeButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filtre"
        label.font = .montserratSemiBold(size: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var titleSeperatorView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mainGrayColor
        return view
    }()
    
    private lazy var filterCustomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    
    init(viewModel: FilterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureStackView()
        addComponents()
        configureLayout()
    }
    
    private func configureStackView(){
        viewModel.filterTypeList.forEach { type in
            var itemList = [String]()
            switch type {
            case .brand:
                itemList = viewModel.uniqueBrands
            case .name:
                itemList = viewModel.uniqueNames
            }
            let filterView = FilterCustomView(filterTypeList: itemList)
            filterView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            filterCustomStackView.addArrangedSubview(filterView)
        }
    }
    
    private func addComponents(){
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(titleSeperatorView)
        view.addSubview(filterCustomStackView)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            
            titleSeperatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleSeperatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleSeperatorView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 5),
            titleSeperatorView.heightAnchor.constraint(equalToConstant: 2),
            
            filterCustomStackView.topAnchor.constraint(equalTo: titleSeperatorView.bottomAnchor, constant: 20),
            filterCustomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            filterCustomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
}
