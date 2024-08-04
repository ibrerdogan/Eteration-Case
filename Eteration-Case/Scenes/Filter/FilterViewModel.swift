//
//  FilterViewModel.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 4.08.2024.
//

import Foundation
import UIKit
protocol FilterViewModelDataSource {
    var productItemList: [ETProduct] {get set}
    var filteredItemList: [ETProduct] {get set}
    var filterTypeList: [FilterType] {get set}
    var uniqueNames: [String] {get set}
    var uniqueBrands: [String] {get set}
    var uniqueModels: [String] {get set}
}

protocol FilterViewModelEventSource: FilterViewModelDataSource {
    func getProductNames()
    func getProductBrand()
}

protocol FilterViewModelProtocol: FilterViewModelEventSource { }

final class FilterViewModel: FilterViewModelProtocol {
    var filteredItemList =  [ETProduct]()
    var uniqueNames = [String]()
    var uniqueBrands = [String]()
    var uniqueModels = [String]()
    var filterTypeList = [FilterType]()
    var productItemList: [ETProduct]
    
    init(productItemList: [ETProduct]) {
        self.productItemList = productItemList
        self.filteredItemList = productItemList
        getProductNames()
        getProductBrand()
        getProductModels()
    }
    
    func getProductNames() {
        uniqueNames = Array(Set(productItemList.map { $0.name })).sorted()
        if !uniqueNames.isEmpty{
            filterTypeList.append(.name)
        }
    }
    
    func getProductBrand() {
        uniqueBrands = Array(Set(productItemList.map { $0.brand })).sorted()
        if !uniqueBrands.isEmpty{
            filterTypeList.append(.brand)
        }
    }
    
    func getProductModels() {
        uniqueModels = Array(Set(productItemList.map { $0.model })).sorted()
        if !uniqueModels.isEmpty{
            filterTypeList.append(.model)
        }
    }
    
    func filter(isSelected: Bool,filterText: String, type: FilterType)
    {
        if isSelected {
            switch type {
            case .brand:
                filteredItemList = filteredItemList.filter({$0.brand == filterText})
            case .name:
                filteredItemList = filteredItemList.filter({$0.name == filterText})
            case .model:
                filteredItemList = filteredItemList.filter({$0.model == filterText})
            }
        }else {
            filteredItemList = productItemList
        }
    }
    
}
