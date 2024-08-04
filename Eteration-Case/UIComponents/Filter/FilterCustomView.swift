//
//  FilterCustomView.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 4.08.2024.
//

import Foundation
import UIKit
final class FilterCustomView: UIView{
    var filterTypeList: [String]
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .montserratLight(size: 14)
        label.textColor = .mainBlueColor?.withAlphaComponent(0.4)
        label.text = "test"
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search",
                                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.mainBlueColor?.withAlphaComponent(0.3) ?? .gray,
                                                                                          NSAttributedString.Key.font: UIFont.montserratMedium(size: 18)])
        //searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var filterTypeTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilterCustomViewCell.self, forCellReuseIdentifier: FilterCustomViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    init(filterTypeList: [String]) {
        self.filterTypeList = filterTypeList
        super.init(frame: .zero)
        addComponents()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents(){
        addSubview(titleLabel)
        addSubview(searchBar)
        addSubview(filterTypeTableView)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            filterTypeTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            filterTypeTableView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 10),
            filterTypeTableView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -10),
            filterTypeTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
extension FilterCustomView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = filterTypeTableView.dequeueReusableCell(withIdentifier: FilterCustomViewCell.identifier, for: indexPath) as? FilterCustomViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: filterTypeList[indexPath.row], isSelected: false)
        return cell
    }
    
    
}
