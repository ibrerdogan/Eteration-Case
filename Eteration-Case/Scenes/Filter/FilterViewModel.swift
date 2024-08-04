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
    var filterTypeList: [FilterType] {get set}
    var uniqueNames: [String] {get set}
    var uniqueBrands: [String] {get set}
}

protocol FilterViewModelEventSource: FilterViewModelDataSource {
    func getProductNames()
    func getProductBrand()
}

protocol FilterViewModelProtocol: FilterViewModelEventSource { }

final class FilterViewModel: FilterViewModelProtocol {
    var uniqueNames = [String]()
    var uniqueBrands = [String]()
    var filterTypeList = [FilterType]()
    var productItemList: [ETProduct]
    
    init(productItemList: [ETProduct]) {
        self.productItemList = productItemList
        getProductNames()
        getProductBrand()
    }
    
    func getProductNames() {
        uniqueNames = Array(Set(productItemList.map { $0.name })).sorted()
        if !uniqueNames.isEmpty{
            filterTypeList.append(.name)
        }
    }
    
    func getProductBrand() {
        uniqueBrands = Array(Set(productItemList.map { $0.brand })).sorted()
        if !uniqueNames.isEmpty{
            filterTypeList.append(.brand)
        }
    }
    
}
