//
//  FilterContainerView.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 3.08.2024.
//

import Foundation
import UIKit

final class FilterContainerView: UIView{
    var openFilter:()->() = {}
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var filterTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "Filter:"
        label.font = .montserratRegular(size: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select Filter", for: .normal)
        button.backgroundColor = .mainGrayColor
        button.titleLabel?.font = .montserratRegular(size: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
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
    
    
    private func addComponents(){
        containerView.addSubview(filterTextLabel)
        containerView.addSubview(filterButton)
        addSubview(containerView)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            filterTextLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            filterTextLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            filterButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            filterButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            filterButton.heightAnchor.constraint(equalToConstant: 36),
            filterButton.widthAnchor.constraint(equalToConstant: 158),
            
            containerView.bottomAnchor.constraint(equalTo: filterButton.bottomAnchor),
            
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            
        ])
    }
    
    @objc func filterButtonTapped(){
        openFilter()
    }
    
}
