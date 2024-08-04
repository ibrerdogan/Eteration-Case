//
//  Enums.swift
//  Eteration-Case
//
//  Created by İbrahim Erdogan on 4.08.2024.
//

import Foundation
enum FilterType : String{
    case brand = "Brand"
    case name = "Name"
    case model = "Model"
    case sort = "Sort by"
}

enum FilterSortTypes: String {
    case oldToNew = "Old to New"
    case newToOld = "New to Old"
    case priceHightToLow = "Price Hight to Low"
    case priceLowToHight = "Price Low to Heigh"
}
