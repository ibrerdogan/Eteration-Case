//
//  FilterCustomViewCell.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 4.08.2024.
//

import UIKit
final class FilterCustomViewCell: UITableViewCell{
    static let identifier = "FilterCustomViewCell"
    var isFilterSelected: Bool = false
    var filterString: String = ""
    var changeFilter: (Bool,String)->() = { _,_ in}
    
    private lazy var selectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "square")
        return imageView
    }()
    
    private lazy var filterSectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponents()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with name: String, isSelected: Bool){
        filterSectionTitleLabel.text = name
        filterString = name
        isFilterSelected = isSelected
    }
    
    func changeSelection(){
        isFilterSelected.toggle()
        configureSelectImage(isSelected: isFilterSelected)
        changeFilter(isFilterSelected, filterString)
    }
    
    private func configureSelectImage(isSelected: Bool){
        selectionImageView.image = isSelected ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
    }
    
    private func addComponents()
    {
        contentView.addSubview(selectionImageView)
        contentView.addSubview(filterSectionTitleLabel)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            selectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            selectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            selectionImageView.heightAnchor.constraint(equalToConstant: 20),
            selectionImageView.widthAnchor.constraint(equalToConstant: 20),
            
            filterSectionTitleLabel.centerYAnchor.constraint(equalTo: selectionImageView.centerYAnchor),
            filterSectionTitleLabel.leadingAnchor.constraint(equalTo: selectionImageView.trailingAnchor, constant: 10),
            filterSectionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            contentView.bottomAnchor.constraint(equalTo: selectionImageView.bottomAnchor, constant: 5),
        ])
    }
    
    
    
}
