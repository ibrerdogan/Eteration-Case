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
    var staticFilterTypeList: [String]
    var filterType: FilterType
    var applieFilter: (Bool,String,FilterType)->() = { _,_,_ in}
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .montserratLight(size: 14)
        label.textColor = .mainBlueColor?.withAlphaComponent(0.4)
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
        searchBar.delegate = self
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
    init(filterTypeList: [String], filterType: FilterType) {
        self.filterTypeList = filterTypeList
        self.filterType = filterType
        self.staticFilterTypeList = filterTypeList
        super.init(frame: .zero)
        titleLabel.text = filterType.rawValue
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
    
    func filterBySearch(with text: String){
        if !text.isEmpty{
            let newArray = staticFilterTypeList.filter({$0.contains(text)})
            filterTypeList = newArray
            updateView()
        }else {
            filterTypeList = staticFilterTypeList
            updateView()
        }
    }
    
    private func updateView(){
        filterTypeTableView.reloadData()
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
        cell.selectionStyle = .none
        cell.changeFilter = {[weak self] isSelect,filterName in
            guard let strongSelf = self else {return}
            strongSelf.applieFilter(isSelect,filterName,strongSelf.filterType)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       guard let cell = filterTypeTableView.cellForRow(at: indexPath) as? FilterCustomViewCell else {return}
        cell.changeSelection()
    }
}

extension FilterCustomView: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filterBySearch(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        filterBySearch(with: "")
    }

}
